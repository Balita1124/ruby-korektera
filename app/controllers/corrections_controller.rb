#!/usr/bin/env ruby
# coding: utf-8
class CorrectionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_correction, only: [:show, :edit, :update, :destroy]


  # GET /corrections
  # GET /corrections.json
  def index
    @corrections = Correction.all
  end

  # GET /corrections/1
  # GET /corrections/1.json
  def show
  end

  # GET /corrections/new
  def new
    @correction = Correction.new
  end

  # GET /corrections/1/edit
  def edit
    @project = Project.find(@correction.project_id)
    @corrections = Correction.where(:project_id => @project.id).order("etat asc").paginate(page: params[:page], :per_page => 5)
    @sess = Sess.new
    @corrections_all = Correction.where(:project_id => @project.id).count
    @corrections_not_corriged = Correction.where("project_id = ? and etat=?", @project.id, 0).count
    if current_user.groupe == 2
      @corrections_mines = Correction.where("project_id = ? and user_id=?", @project.id, current_user.id).count
    elsif current_user.groupe == 1
      @corrections_mines = Correction.where("project_id = ? and user_correcteur_id=? and etat > 0", @project.id, current_user.id).count
    end
  end

  # POST /corrections
  # POST /corrections.json
  def create
    action = "Ajouter une correction"
    @correction = Correction.new(correction_params)
    if @correction.save
      @sess = Sess.new
      @project = Project.find(params[:correction][:project_id])
      @corrections = Correction.where(:project_id => @project.id).order("etat asc").paginate(page: params[:page], :per_page => 5)
      @corrections_all = Correction.where(:project_id => @project.id).count
      if current_user.groupe == 2
        @corrections_mines = Correction.where("project_id = ? and user_id=?", @project.id, current_user.id).count
      elsif current_user.groupe == 1
        @corrections_mines = Correction.where("project_id = ? and user_correcteur_id=? and etat > 0", @project.id, current_user.id).count
      end
      @corrections_not_corriged = Correction.where("project_id = ? and etat=?", @project.id, 0).count
      @historique = Historique.new({:user_id => current_user.id, :action => action, :project => @project.id, :correction => @correction.id})
      @historique.save
      @fresh = @correction
      @correction = Correction.new
    end
  end

  # PATCH/PUT /corrections/1
  # PATCH/PUT /corrections/1.json
  def update
    if current_user.groupe == 1 || current_user.groupe == 3
      action = "corriger"
    elsif current_user.groupe == 2 || current_user.groupe == 4
      @sess = Sess.new
      action = "modifier une correction"
    end
    if @correction.update(correction_params)
      @project = Project.find(@correction.project_id)
      @corrections = Correction.where(:project_id => @project.id).order("etat asc").paginate(page: params[:page], :per_page => 5)
      @corrections_all = Correction.where(:project_id => @project.id).count
      if current_user.groupe == 2
        @corrections_mines = Correction.where("project_id = ? and user_id=?", @project.id, current_user.id).count
      elsif current_user.groupe == 1
        @corrections_mines = Correction.where("project_id = ? and user_correcteur_id=? and etat > 0", @project.id, current_user.id).count
      end

      @corrections_not_corriged = Correction.where("project_id = ? and etat=?", @project.id, 0).count
      @historique = Historique.new({:user_id => current_user.id, :action => action, :project => @project.id, :correction => @correction.id})
      @historique.save
    end
    @correction =Correction.new
    # abort @correction.inspect
  end

  # DELETE /corrections/1
  # DELETE /corrections/1.json
  def destroy
    action = "supprimer une correction"
    @project = Project.find(@correction.project_id)
    @correction.destroy
    @corrections = Correction.where(:project_id => @project.id).order("etat asc").paginate(page: params[:page], :per_page => 5)
    @corrections_all = Correction.where(:project_id => @project.id).count
    if current_user.groupe == 2
      @corrections_mines = Correction.where("project_id = ? and user_id=?", @project.id, current_user.id).count
    elsif current_user.groupe == 1
      @corrections_mines = Correction.where("project_id = ? and user_correcteur_id=? and etat > 0", @project.id, current_user.id).count
    end
    @corrections_not_corriged = Correction.where("project_id = ? and etat=?", @project.id, 0).count
    @historique = Historique.new({:user_id => current_user.id, :action => action, :project => @project.id, :correction => @correction.id})
    @historique.save
    @sess = Sess.new
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_correction
    @correction = Correction.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def correction_params
    params.require(:correction).permit(:avant, :project_id, :user_id, :ligne, :action, :demande, :page, :description, :etat, :commentaires, :user_correcteur_id, :view_line)
  end
end
