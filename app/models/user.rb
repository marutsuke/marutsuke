class User < ApplicationRecord
  before_save { email&.downcase! }
  validates :email, format: { with: VALIDATE_FORMAT_OF_EMAIL }, uniqueness:{ case_sensitive: false}, allow_nil: true
  has_secure_password

  belongs_to :school

  def auto_login_id_create(school)
    login_id = school.id.to_s + sprintf("%06d", school.users.count)
  end
end

  # validates :name, presence: {message:"名前を入力してください。"}
  # # , length: {maximum:12, message:"名前は10文字以内でお願いします。"}
  # validates :login_id, presence: {message:"ログインIDを入力してください。"}, uniqueness: {message: "同じログインIDが存在します。別のIDに変えてください。"}, length: {maximum: 12, message:"ログインIDは、12文字以内となります。"}
  # validates :password, presence: true, confirmation: true
