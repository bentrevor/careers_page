require 'spec_helper'

describe JobApplicationController do
  let(:open_position)   { Position.create(openings: 1) }
  let(:closed_position) { Position.create(openings: 0) }

  describe '#new' do
    it 'status == 200' do
      get :new, position_id: open_position.id

      expect(response.status).to eq 200
    end

    it 'refers to a specific Position' do
      get :new, position_id: open_position.id

      expect(assigns(:position)).to eq open_position
    end

    it 'makes a new JobApplication' do
      get :new, position_id: open_position.id

      expect(assigns(:job_application)).to be_a JobApplication
    end

    it "redirects home for a position_id that doesn't exist" do
      get :new, position_id: -1

      expect(response).to redirect_to home_path
    end

    it "redirects home for a Position that doesn't have openings" do
      get :new, position_id: closed_position

      expect(response).to redirect_to home_path
    end
  end

  describe '#create' do
    context 'valid attrs' do
      let(:attrs) {{ name: 'name', phone: '123-123-4567', email: 'asdf@jkl.com', position_id: open_position.id }}

      it 'creates a JobApplication' do
        expect {
          post :create, attrs: attrs
        }.to change{JobApplication.count}.by 1
      end
    end

    context 'invalid attrs' do
      let(:attrs) {{ name: '', phone: '', email: '', position_id: closed_position.id }}

      it "doesn't create a JobApplication" do
        expect {
          post :create, attrs: attrs
        }.to change{JobApplication.count}.by 0
      end

      # TODO
      xit "shows a flash message and doesn't reload the page" do
        # expect {
        #   post :create, attrs: attrs
        # }.to
      end
    end
  end
end
