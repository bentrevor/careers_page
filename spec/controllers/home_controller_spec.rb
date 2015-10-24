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
      position_without_openings = FactoryGirl.create(:position_without_openings)
      position_with_openings = FactoryGirl.create(:position_with_openings)

      get :careers

      expect(assigns(:open_positions)).to eq [position_with_openings]
    end
  end
end
