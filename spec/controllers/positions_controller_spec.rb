require 'spec_helper'

describe PositionsController do
  let(:position) { FactoryGirl.create(:position) }
  let(:position_id) { position.id }

  let(:valid_attrs) {
    {
      name: 'job title',
      description: 'job desc',
      openings: 100,
    }
  }
  let(:valid_position_id) { position.id }

  describe '#new' do
    before do
      get :new
    end

    it 'status == 200' do
      expect(response.status).to eq 200
    end

    it 'builds a position' do
      expect(assigns(:position)).to be_a Position
    end
  end

  describe '#edit' do
    before do
      get :edit, id: position_id
    end

    it 'status == 200' do
      expect(response.status).to eq 200
    end

    it 'shows a form to update a position' do
      expect(assigns(:position)).to eq position
    end

    context 'invalid position id' do
      let(:position_id) { -1 }

      it 'redirects to the positions list with a flash message' do
        expect(flash[:error]).to eq I18n.t('flash.position_does_not_exist')
        expect(response).to redirect_to positions_path
      end
    end
  end

  describe '#update' do
    before do
      put :update, id: position_id, position: attrs
    end

    context 'with valid attrs' do
      let(:attrs) { valid_attrs }
      let(:position_id) { valid_position_id }

      it 'updates the position' do
        position.reload

        expect(position.name).to eq 'job title'
        expect(position.description).to eq 'job desc'
        expect(position.openings).to eq 100
      end

      it 'redirects to the position page with a flash message' do
        expect(flash[:success]).to eq I18n.t('flash.position_successfully_updated')
        expect(response).to redirect_to position_path(position)
      end
    end

    context 'invalid attrs' do
      let(:attrs) { valid_attrs.merge!(name: '') }
      let(:position_id) { valid_position_id }

      it 'shows a flash message and redirects back to the form' do
        expect(flash[:error]).to include I18n.t('flash.invalid_attr')
        expect(flash[:error]).to include "Name can't be blank"
        expect(response).to redirect_to edit_position_path(position)
      end
    end

    context 'invalid position id' do
      let(:attrs) { valid_attrs }
      let(:position_id) { -1 }

      it 'shows a flash message and redirects back to the list of positions' do
        expect(flash[:error]).to eq I18n.t('flash.position_does_not_exist')
        expect(response).to redirect_to positions_path
      end
    end
  end

  describe '#create' do
    before do
      post :create, position: attrs
    end

    context 'all valid attrs' do
      let(:attrs) { valid_attrs }
      let(:position_id) { valid_position_id }

      it 'creates a position' do
        expect(Position.count).to eq 1

        position = Position.last

        expect(position.name).to eq 'job title'
        expect(position.description).to eq 'job desc'
        expect(position.openings).to eq 100
      end

      it "redirects to the position's page" do
        expect(flash[:success]).to eq I18n.t('flash.position_successfully_created')
        expect(response).to redirect_to position_path(Position.last)
      end
    end

    context 'invalid attr' do
      let(:position_id) { valid_position_id }

      context 'blank attr' do
        let(:attrs) { valid_attrs.merge!(name: '') }

        it "doesn't create a Position" do
          expect(Position.count).to eq 0
        end

        it 'redirects back to the form with a flash message' do
          expect(flash[:error]).to include I18n.t('flash.invalid_attr')
          expect(flash[:error]).to include "Name can't be blank"
          expect(response).to redirect_to new_position_path
        end
      end

      context 'negative openings' do
        let(:attrs) { valid_attrs.merge!(openings: -2) }

        it "doesn't create a Position" do
          expect(Position.count).to eq 0
        end

        it 'redirects back to the form with a flash message' do
          expect(flash[:error]).to include I18n.t('flash.invalid_attr')
          expect(flash[:error]).to include "Openings must be greater than or equal to 0"
          expect(response).to redirect_to new_position_path
        end
      end
    end
  end

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

      it 'redirects to the positions list with a flash message' do
        expect(flash[:error]).to eq I18n.t('flash.position_does_not_exist')
        expect(response).to redirect_to positions_path
      end
    end
  end
end
