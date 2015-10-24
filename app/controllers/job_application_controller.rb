class JobApplicationController < ApplicationController
  def new
    @position = Position.find_by_id(params[:position_id])

    if @position && @position.has_openings?
      @job_application = JobApplication.new
    else
      redirect_to home_path
    end
  end

  def create
    attrs = params[:job_application].merge!(params.slice(:position_id))
    position = Position.find_by_id(attrs[:position_id])

    if position && position.has_openings?
      # TODO strong params
      job_application = JobApplication.create(
        name: attrs[:name],
        phone: attrs[:phone],
        email: attrs[:email],
        resume: attrs[:resume],
        cover_letter: attrs[:cover_letter],
        position: position,
      )
    end

    if job_application
      if job_application.valid?
        flash[:success] = "You have applied for the #{position.name} position."
      else
        flash[:error] = job_application.errors.full_messages.to_sentence
        redirect_to job_applications_path(position.id) and return
      end
    else
      if position
        flash[:error] = "There are no openings for the #{position.name} position."
      else
        flash[:error] = "Something went wrong..."
      end
    end

    redirect_to careers_path
  end
end
