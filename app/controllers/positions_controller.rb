class PositionsController < ApplicationController
  def new
    @position = Position.new
  end

  def create
    position = Position.new(permitted_params)

    if position.save
      render_valid_position_creation(position)
    else
      render_invalid_position_creation(position)
    end
  end

  def edit
    if !@position = Position.find_by_id(params[:id])
      render_invalid_position
    end
  end

  def update
    if position = Position.find_by_id(params[:id])
      render_position_update(position)
    else
      render_invalid_position
    end
  end

  def index
    @positions = Position.all
  end

  def show
    if !@position = Position.find_by_id(params[:id])
      render_invalid_position
    end
  end

  def careers
    @open_positions = Position.with_openings
  end

  private

  def permitted_params
    params.require(:position).permit(:name, :description, :openings)
  end

  def render_position_update(position)
    if position.update_attributes(permitted_params)
      render_valid_position_update(position)
    else
      render_invalid_position_update(position)
    end
  end

  def render_valid_position_update(position)
    flash[:success] = I18n.t('flash.position_successfully_updated')
    redirect_to position_path(position)
  end

  def render_valid_position_creation(position)
    flash[:success] = I18n.t('flash.position_successfully_created')
    redirect_to position_path(position)
  end

  def render_invalid_position_update(position)
    flash[:error] = I18n.t('flash.invalid_attr') + position.errors.full_messages.to_sentence
    redirect_to edit_position_path(position)
  end

  def render_invalid_position_creation(position)
    flash[:error] = I18n.t('flash.invalid_attr') + position.errors.full_messages.to_sentence
    redirect_to new_position_path
  end

  def render_invalid_position
    flash[:error] = I18n.t('flash.position_does_not_exist')
    redirect_to positions_path
  end
end
