#!/usr/bin/env ruby
# coding: utf-8
class UtilisateursController < ApplicationController
  before_action :authenticate_user!
  before_action :access_admin?, except: :show
  before_action :set_utilisateur, only: [:show, :edit, :update, :destroy]
  layout :resolve_layout

  # GET /utilisateurs
  # GET /utilisateurs.json
  def index
    @utilisateurs = User.all.order(groupe: :asc).paginate(page: params[:page], :per_page => 5)
  end

  # GET /utilisateurs/1
  # GET /utilisateurs/1.json
  def show
    if !admin?
      if current_user.groupe == 1 || current_user.groupe == 3
        # @projects = Project.where("user_id = ?",current_user.id)
        @corrections = Correction.where("user_correcteur_id = ?", current_user.id).group("project_id")
      elsif current_user.groupe == 2 || current_user.groupe == 4
        @corrections = Correction.where("user_id = ?", current_user.id).group("project_id")
      end
      @historiques = Historique.where("user_id =?", current_user.id).order(updated_at: :desc).limit(10)
    end
    # abort @corrections.inspect
  end

  # GET /utilisateurs/new
  def new
    @utilisateur = User.new
  end

  # GET /utilisateurs/1/edit
  def edit
  end

  # POST /utilisateurs
  # POST /utilisateurs.json
  def create
    @utilisateur = User.new(utilisateur_params)
    #abort @utilisateur.inspect
      if @utilisateur.save
        redirect_to utilisateurs_path, notice: "L'utilisateur a été créé"
      else
        render :new
      end
  end

  # PATCH/PUT /utilisateurs/1
  # PATCH/PUT /utilisateurs/1.json
  def update
      if @utilisateur.update(utilisateur_params)
        redirect_to utilisateurs_path, notice: "L'utilisateur a été modifié"
      else
        render :edit
      end
  end

  # DELETE /utilisateurs/1
  # DELETE /utilisateurs/1.json
  def destroy
    @utilisateur.destroy
    redirect_to utilisateurs_path, notice: "L'utilisateur a été modifié"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_utilisateur
    @utilisateur = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def utilisateur_params
    params.require(:user).permit(:nom,:prenom,:groupe,:email,:password,:password_confirmation)
  end
  def resolve_layout
    if admin?
      "administrateur"
    else
      "application"
    end
  end
end
