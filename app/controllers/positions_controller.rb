class PositionsController < ApplicationController
  def index
    @positions = Position.all
  end

  def show
    @position = Position.find_by_id(params[:id])

    if !@position
      flash[:error] = I18n.t('flash.invalid_position_id')
      redirect_to positions_path
    end
  end
end
