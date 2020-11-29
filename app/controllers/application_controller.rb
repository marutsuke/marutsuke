# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper
  include LineApiHelper
  include SchoolYearHelper
  include SchoolGradeHelper

  class Forbidden < ActionController::ActionControllerError; end
  class LoginRequired < ActionController::ActionControllerError; end
  include ErrorHandlers if Rails.env.production?

end
