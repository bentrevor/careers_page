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
      binding.pry

      get :about

      expect(response.status).to eq 200
    end
  end

  describe 'GET careers' do
    it 'status == 200' do
      get :careers

      expect(response.status).to eq 200
    end
  end
end
