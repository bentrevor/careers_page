class JobApplicationController < ApplicationController
  def new
    @position = Position.find_by_id(params[:position_id])

    if @position.try(:has_openings?)
      @job_application = JobApplication.new
    else
      render_invalid_position
    end
  end

  def create
    attrs = params[:job_application].merge!(params.slice(:position_id))
    position = Position.find_by_id(attrs[:position_id])

    job_application = JobApplication.create(permitted_params)

    if job_application.valid?
      flash[:success] = I18n.t('flash.job_application_successfully_created', name: position.name)
    else
      if invalid_position?(position)
        render_invalid_position and return
      end

      flash[:error] = I18n.t('flash.invalid_attr') + job_application.errors.full_messages.to_sentence
      redirect_to job_applications_path(position.id) and return
    end

    redirect_to careers_path
  end

  private

  def invalid_position?(position)
    position.nil? || !position.has_openings?
  end

  def render_invalid_position
    flash[:error] = I18n.t('flash.invalid_position_id')
    redirect_to careers_path
  end

  def permitted_params
    params.require(:job_application).permit(:name, :phone, :email, :resume, :cover_letter, :position_id)
  end
end
