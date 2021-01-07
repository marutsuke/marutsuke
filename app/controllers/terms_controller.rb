class TermsController < UserBase
  skip_before_action :user_login_required,
  :school_select_required,
  only: :index

  layout 'user_layout_without_header'

  def index

  end
end
