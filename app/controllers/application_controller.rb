class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def require_login
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
