require 'spec_helper'

describe HomeController do
  describe 'GET home' do
    it 'status == 200' do
      get :home

      expect(response.status).to eq 200
    end
  end

  describe 'GET about' do
    it 'status == 200' do
      get :about

      expect(response.status).to eq 200
    end
  end

  describe 'GET careers' do
    it 'status == 200' do
      get :careers

      expect(response.status).to eq 200
    end

    it 'has a list of positions with openings' do
      position_without_opening = Position.create(name: 'position without opening', openings: 0)
      position_with_opening = Position.create(name: 'position with opening', openings: 1)

      get :careers

      expect(assigns(:open_positions).length).to be 1

      expect(assigns(:open_positions)).to include position_with_opening
      expect(assigns(:open_positions)).not_to include position_without_opening
    end
  end
end
