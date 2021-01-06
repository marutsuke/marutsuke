class AgreementConfirmsController < UserBase
  skip_before_action :user_login_required,
  :school_select_required,
  only: :index

  def index

  end
end
