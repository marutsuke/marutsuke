# frozen_string_literal: true
require 'net/http'
require 'uri'

class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  attr_accessor :user_remember_token,
                :user_line_state_token
  before_save { email&.downcase! }
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, format: { with: VALIDATE_FORMAT_OF_EMAIL },
                    length: { maximum: 50, minimum: 8 },
                    uniqueness: { case_sensitive: false },
                    allow_blank: true
  validates :school_grade, presence: true

  # パスワードのバリデーション(emailでログインの時のみ)
  # See: https://github.com/rails/rails/blob/master/activemodel/lib/active_model/secure_password.rb
  has_secure_password validations: false
  validates :password, presence: true, length: { minimum: 8 }, allow_blank: true, on: :email_authentication
  validate(on: :email_authentication) do |record|
    record.errors.add(:password, :blank) if record.password_digest.blank?
  end
  validates_length_of :password, maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED, on: :email_authentication
  validates_confirmation_of :password, presence: true, on: :email_authentication

  has_many :answers, dependent: :destroy
  has_many :question_statuses, dependent: :destroy
  has_many :school_building_users, dependent: :destroy
  has_many :school_users, dependent: :destroy
  has_many :schools, through: :school_users
  has_many :lesson_group_users, dependent: :destroy
  has_many :join_requests, dependent: :destroy
  has_many :lesson_group_requests, dependent: :destroy
  has_many :cancel_reasons
  has_one :user_authentication, dependent: :destroy
  has_many :questions, through: :question_statuses
  has_many :school_buildings, through: :school_building_users
  has_many :lesson_groups, through: :lesson_group_users
  accepts_nested_attributes_for :school_building_users, allow_destroy: true

  paginates_per 20
  mount_uploader :image, ImageUploader

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def email_to_authentication
    if user_authentication.provider == 'email'
      user_authentication.uid
    else
      nil
    end
  end

  def change_authenticatoin_email_to_line(line_user_id)
    user_authentication.update(provider: 'line', uid: line_user_id)
    end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.user_remember_token = self.class.new_token
    update_attribute(:remember_digest, self.class.digest(user_remember_token))
  end

  def authenticated?(user_remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(user_remember_token)
  end

  def line_state_save
    self.user_line_state_token = self.class.new_token
    update_attribute(:line_state_digest, self.class.digest(user_line_state_token))
  end

  def line_authenticated?(user_line_state_token)
    return false if line_state_digest.nil?

    BCrypt::Password.new(line_state_digest).is_password?(user_line_state_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def main_school_building(school)
    school.school_buildings.joins(:school_building_users).merge(SchoolBuildingUser.where(main: true, user_id: id)).first
  end

  def main_and_sub_school_buildings_names_in(school)
    "#{main_school_building_name_in(school)}(所属校), #{sub_school_buildings_name_in(school)}"
  end

  def school_buildings_main_order(school)
    school.school_buildings.includes(:school_building_users).order('school_building_users.main desc')
  end

  def sub_school_buildings(school)
    school.school_buildings.joins(:school_building_users).merge(SchoolBuildingUser.where(main: false))
  end

  def school_user(school)
    school_users.find_by(school_id: school.id)
  end

  def lesson_groups_in(school)
    lesson_groups.for_school(school)
  end

  def send_comment_notification(comment)
    return unless notification_permission?

    if user_authentication.provider == 'line'
      message = "先生からのコメントがあります。\n\n#{comment.text}\n\nリンク:#{ Rails.application.routes.url_helpers.question_url(comment.answer.question) }"
      send_simple_line_message(message)
    elsif user_authentication.provider == 'email'
      comment.send_notification_email_to_user
    end
  end

  private

  def send_simple_line_message(text)
    return unless user_authentication.provider == 'line'

    message = {
      type: 'text',
      text: text
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = Rails.application.credentials.line_message[:channel_secret]

      config.channel_token = Rails.application.credentials.line_message[:channel_access_token]
    }
    client.push_message(user_authentication.uid, message)
  end

  def main_school_building_name_in(school)
    school.school_buildings.joins(:school_building_users).merge(SchoolBuildingUser.where(main: true, user_id: id)).first.name
  end

  def sub_school_buildings_name_in(school)
    sub_school_buildings = school_buildings.where.not(id: main_school_building(school).id)
    sub_school_buildings.where(school_id: school.id).map(&:name).join(',')
  end

  private
  def image_size
    errors.add(:image, 'サイズは5MBまでです。') if image.size > 5.megabytes
  end
end
