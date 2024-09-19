class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Si necesitas redirigir a la página de inicio de sesión desde algún lugar específico
  def after_sign_in_path_for(resource)
    # Puedes redirigir a una ruta específica después de iniciar sesión
    job_offers_path
  end

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :bio, :profile_image])
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role, :bio, :profile_image])
  end
  def authorize_request(kind = nil)
    unless kind.include?(current_user.role)
      redirect_to root_path, notice: "You are not authorized to perform this action"
    end
  end
end
