class JobApplicationController < ApplicationController
  def new
    @position = Position.find_by_id(params[:position_id])

    if @position && @position.has_openings?
      @job_application = JobApplication.new
    else
      redirect_to home_path
    end
  end
end
