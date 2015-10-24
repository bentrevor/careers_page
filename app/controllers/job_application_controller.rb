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
      JobApplication.create(
        name: attrs[:name],
        phone: attrs[:phone],
        email: attrs[:email],
        resume: attrs[:resume],
        cover_letter: attrs[:cover_letter],
        position: position,
      )
    end

    # TODO redirect somewhere
    render nothing: true
  end
end
