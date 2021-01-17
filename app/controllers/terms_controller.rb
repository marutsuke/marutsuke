class TermsController < UserBase
  skip_before_action :user_login_required,
  :school_select_required,
  only: %i[index privacy_policy]

  layout 'user_layout_simple'

  def index
  end

  def privacy_policy
  end

  def temrs
  end

  def rules
  end

end
