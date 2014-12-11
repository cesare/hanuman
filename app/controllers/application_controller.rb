class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  helper_method :current_person

  private

  def render_not_found
    render file: 'public/404.html', status: :not_found
  end

  def current_person
    person_id = session[:person_id]
    return nil unless person_id

    return @current_person if instance_variable_defined? :@current_person

    @current_person = Person.find_by(id: person_id)
  end

  def person_signed_in?
    current_person.present?
  end

  def authenticate_person!
    return if current_person.present?

    redirect_to auth_path
  end

  def authenticate_admin!
    unless current_person.present?
      redirect_to auth_path
      return
    end

    return if current_person.admin?

    redirect_to root_path
  end
end
