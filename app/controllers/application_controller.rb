class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :authenticate_user!, except: [:top, :about]
  before_action :authenticate_user!, only: [:edit, :update]

  def set_current_user
    @current_user = User.find_by(id :session[:user_id])
  end

  def autheniticate_user
    if @current_user == nil
      redirect_to ("/sign_up")
    end
  end
  
  def autheniticate_user
    if @book.id == nil
      redirect_to ("/books")
    end
  end

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
