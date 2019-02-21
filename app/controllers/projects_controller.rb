#!/usr/bin/env ruby
# coding: utf-8
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  layout "nothing", only: :show

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @correction = Correction.new
    @corrections = Correction.where(:project_id => @project.id).order("etat asc").paginate(page: params[:page], :per_page => 5)
    # abort (@corrections.first.etat).inspect
    @sess = Sess.new
    @corrections_all = Correction.where(:project_id => @project.id).count
    @corrections_not_corriged = Correction.where("project_id = ? and etat=?", @project.id, 0).count
    if current_user.groupe == 2
      @corrections_mines = Correction.where("project_id = ? and user_id=?", @project.id, current_user.id).count
    elsif current_user.groupe == 1
      @corrections_mines = Correction.where("project_id = ? and user_correcteur_id=? and etat > 0", @project.id, current_user.id).count
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    action = "créer un projet"
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        @historique = Historique.new({:user_id => current_user.id, :action => action, :project => @project.id, :correction => nil})
        @historique.save
        @sess = Sess.new
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    action = "supprimer un projet"
    @project.destroy
    respond_to do |format|
      @historique = Historique.new({:user_id => current_user.id, :action => action, :project => @project.id, :correction => nil})
      @historique.save
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name, :fichier, :user_id)
  end
end
