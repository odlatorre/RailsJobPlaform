class JobOffersController < ApplicationController
 # before_action :set_job_offer, only: %i[show edit update destroy apply]
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i[new create edit update destroy]
  # GET /job_offers or /job_offers.json
  def index
    @job_offers = JobOffer.all
  end

  # GET /job_offers/1 or /job_offers/1.json
  def show
    @job_offer = JobOffer.find(params[:id])
  end

  # GET /job_offers/new
  def new
    @job_offer = current_user.job_offers.build
    @users = User.all
  end

  # GET /job_offers/1/edit
  def edit
    @users = User.all
  end

  # POST /job_offers or /job_offers.json
  def create
    @job_offer = current_user.job_offers.build(job_offer_params)

    respond_to do |format|
      if @job_offer.save
        format.html { redirect_to job_offer_url(@job_offer), notice: 'Job offer was successfully created.' }
        format.json { render :show, status: :created, location: @job_offer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_offers/1 or /job_offers/1.json
  def update
    respond_to do |format|
      if @job_offer.update(job_offer_params)
        format.html { redirect_to job_offer_url(@job_offer), notice: 'Job offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_offer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_offers/1 or /job_offers/1.json
  def destroy
    @job_offer.destroy

    respond_to do |format|
      format.html { redirect_to job_offers_url, notice: 'Job offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

def apply
  if user_signed_in?
    # Busca la oferta de trabajo utilizando el ID de los parámetros
    @job_offer = JobOffer.find_by(id: params[:id])

    if @job_offer.nil?
      redirect_to job_offers_path, alert: 'Job offer not found.'
      return
    end

    # Verifica si la aplicación ya existe
    existing_application = Application.find_by(user: current_user, job_offer: @job_offer)

    if existing_application
      # Redirige con un aviso si el usuario ya ha aplicado
      redirect_to @job_offer, alert: 'You have already applied to this job offer.'
    else
      @job_application = Application.new(user: current_user, job_offer: @job_offer)

      if @job_application.save
        ApplicationsMailer.application_notification(@job_application.application).deliver_now # Envía la notificación al admin
        redirect_to @application, notice: 'Aplicación enviada con éxito.'
      else
        redirect_to @job_offer, alert: 'Failed to apply to the job offer.'
      end
    end
  else
    redirect_to new_user_session_path, alert: 'You need to sign in to apply for a job.'
  end
end



  # Ensure only admin users can access certain actions


  private

  def authorize_admin
    unless user_signed_in? && current_user.role == 'admin' # O lo que sea que uses para verificar el rol
      redirect_to root_path, alert: 'Access denied. Admins only.'
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_job_offer
    @job_offer = JobOffer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_offer_params
    params.require(:job_offer).permit(:title, :description)
  end
end
