class HomeController < ApplicationController

  def home
  end

  def about
  end

  def careers
    @open_positions = Position.with_openings
  end

end
