class SessesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sess, only: [:show, :edit, :update, :destroy]

  # GET /sesses
  # GET /sesses.json
  def index
    @sesses = Sess.where("user_id = ?", current_user.id).order(:updated_at => "desc")
  end

  # GET /sesses/1
  # GET /sesses/1.json
  def show
    @historiques = Historique.where("project = :project and user_id = :user and created_at < :date_sess ",{date_sess: @sess.created_at,project: @sess.project_id,user: @sess.user_id})
  end

  # GET /sesses/new
  def new
    @sess = Sess.new
  end

  # GET /sesses/1/edit
  def edit
  end

  # POST /sesses
  # POST /sesses.json
  def create
    @sess = Sess.new(sess_params)

    respond_to do |format|
      if @sess.save
        format.html { redirect_to projects_path }
        format.json { render :show, status: :created, location: @sess }
      else
        format.html { render :new }
        format.json { render json: @sess.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sesses/1
  # PATCH/PUT /sesses/1.json
  def update
    respond_to do |format|
      if @sess.update(sess_params)
        format.html { redirect_to @sess, notice: 'Sess was successfully updated.' }
        format.json { render :show, status: :ok, location: @sess }
      else
        format.html { render :edit }
        format.json { render json: @sess.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sesses/1
  # DELETE /sesses/1.json
  def destroy
    @sess.destroy
    respond_to do |format|
      format.html { redirect_to sesses_url, notice: 'Sess was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sess
      @sess = Sess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sess_params
      params[:sess].permit(:user_id,:project_id)
    end
end
