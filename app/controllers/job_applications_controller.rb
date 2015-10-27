class JobApplicationsController < ApplicationController
  def new
    @position = Position.find_by_id(params[:position_id])

    if invalid_position?(@position)
      render_invalid_position
    else
      @job_application = JobApplication.new
    end
  end

  def create
    job_application = JobApplication.new(permitted_params)

    if job_application.save
      render_valid_job_application(job_application)
    else
      render_invalid_job_application(job_application)
    end
  end

  def index
    @job_applications = JobApplication.all
  end

  def show
    if !@job_application = JobApplication.find_by_id(params[:id])
      flash[:error] = I18n.t('flash.invalid_job_application_id')
      redirect_to job_applications_path
    end
  end

  private

  def permitted_params
    params.require(:job_application).permit(:name, :phone, :email, :resume, :cover_letter, :position_id)
  end

  def render_valid_job_application(job_application)
    flash[:success] = I18n.t('flash.job_application_successfully_created', name: job_application.position.name)
    redirect_to careers_path
  end

  def render_invalid_position
    flash[:error] = I18n.t('flash.invalid_position_id')
    redirect_to careers_path
  end

  def render_invalid_job_application(job_application)
    position = Position.find_by_id(permitted_params[:position_id])

    if invalid_position?(position)
      render_invalid_position
    else
      render_invalid_job_application_attr(job_application)
    end
  end

  def render_invalid_job_application_attr(job_application)
    flash[:error] = I18n.t('flash.invalid_attr') + job_application.errors.full_messages.to_sentence
    redirect_to new_job_application_path(job_application.position.id)
  end

  def invalid_position?(position)
    !position.try(:has_openings?)
  end
end
