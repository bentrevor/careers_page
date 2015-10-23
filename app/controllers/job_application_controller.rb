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
    # TODO redirect somewhere
    attrs = params[:attrs]
    position = Position.find_by_id(attrs[:position_id])

    if position && position.has_openings?
      JobApplication.create(
        name: attrs[:name],
        phone: attrs[:phone],
        email: attrs[:email],
        position: position,
      )
    end

    render nothing: true
  end
end
