class NewUserActivationForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :name, :string
  attribute :password, :string
  attribute :password_confirmation, :string
  attribute :school_user_activation_token
  validates :name, presence: true, length: { maximum: 12 }
  validate :user_password_valiadation

  def initialize(school_user, params = {})
    @school_user = school_user
    super(params)
  end

  def save
    return false if invalid?

    user.save!
    @school_user.update!(user_id: user.id)
    @school_user.main_school_building_user_create!

    true
  end

  def user
    @user ||= User.new(name: name, password: password, password_confirmation: password_confirmation, email: @school_user.email)
  end

  private

  def user_password_valiadation
    if password.length < 6
      errors.add(:password, 'は6文字以上で入力してください。')
    elsif password != password_confirmation
      errors.add(:password, 'が一致しません')
    end
  end
end
