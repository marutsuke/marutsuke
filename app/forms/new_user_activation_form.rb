class NewUserActivationForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :name, :string
  attribute :password, :string
  attribute :password_confirmation, :string
  attribute :school_user_activation_token
  validates :name, presence: true, length: { maximum: 12 }

  def initialize(school_user, params = {})
    @school_user = school_user
    super(params)
  end

  def save
    return false if invalid?

    user.save!
    @school_user.update!(user_id: user.id)
    SchoolBuildingUser.create!(user_id: user.id, school_building_id: @school_user.invited_school_building_id, main: true)

    true
  end

  def user
    @user ||= User.new(name: name, password: password, password_confirmation: password_confirmation, email: @school_user.email)
  end


end
