require 'spec_helper'

describe PositionsController do
  let(:position) { FactoryGirl.create(:position) }
  let(:position_id) { position.id }

  describe '#index' do
    before do
      get :index
    end

    it 'status == 200' do
      expect(response.status).to eq 200
    end

    it 'shows a list of all positions' do
      3.times { |n| FactoryGirl.create(:position, name: n.to_s) }

      expect(assigns(:positions)).to eq Position.all
    end
  end

  describe '#show' do
    before do
      get :show, id: position_id
    end

    it 'status == 200' do
      expect(response.status).to eq 200
    end

    it 'shows a position' do
      expect(assigns(:position)).to eq position
    end

    context 'invalid position id' do
      let(:position_id) { -1 }

      it 'redirects home with a flash message for an invalid position id' do
        expect(flash[:error]).to eq I18n.t('flash.invalid_position_id')
        expect(response).to redirect_to positions_path
      end
    end
  end
end
