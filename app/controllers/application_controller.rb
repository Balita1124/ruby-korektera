#!/usr/bin/env ruby
# coding: utf-8
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :devise_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  def devise_permitted_parameters
    # devise_parameter_sanitizer.
    #     for(:sign_in) { |user| user.permit(:email, :password, :nom, :prenom, :groupe) }
    # devise_parameter_sanitizer.
    #     for(:sign_up) { |user| user.permit(:email, :password, :nom, :prenom, :groupe) }

    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :nom, :prenom, :groupe])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :nom, :prenom, :groupe])
  end

  def admin?
    return true if current_user.groupe == 0 else return false
  end

  def access_admin?
    if !admin?
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(resource)
    if admin?
      utilisateurs_path
    else
      root_path
    end
  end

  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

end
