require 'spec_helper'

describe JobApplicationController do
  let(:position_with_openings)    { FactoryGirl.create(:position_with_openings) }
  let(:position_without_openings) { FactoryGirl.create(:position_without_openings) }

  describe '#new' do
    it 'status == 200' do
      get :new, position_id: position_with_openings.id

      expect(response.status).to eq 200
    end

    it 'refers to a specific Position' do
      get :new, position_id: position_with_openings.id

      expect(assigns(:position)).to eq position_with_openings
    end

    it 'makes a new JobApplication' do
      get :new, position_id: position_with_openings.id

      expect(assigns(:job_application)).to be_a JobApplication
    end

    it "redirects home for a position_id that doesn't exist" do
      get :new, position_id: -1

      expect(response).to redirect_to home_path
    end

    it "redirects home for a Position that doesn't have openings" do
      get :new, position_id: position_without_openings

      expect(response).to redirect_to home_path
    end
  end

  describe '#create' do
    let(:attrs) {{ name: 'name', phone: '123-123-4567', email: 'asdf@jkl.com' }}

    context 'all valid attrs' do
      it 'creates a JobApplication' do
        expect {
          post :create, position_id: position_with_openings.id, job_application: attrs
        }.to change{JobApplication.count}.by 1

        job_app = JobApplication.last

        expect(job_app.name).to eq 'name'
        expect(job_app.phone).to eq '123-123-4567'
        expect(job_app.email).to eq 'asdf@jkl.com'
        expect(job_app.position).to eq position_with_openings
      end
    end

    describe 'invalid attr' do
      context "position doesn't exist" do
        it "doesn't create a JobApplication" do
          expect {
            post :create, position_id: 'asdf', job_application: attrs
          }.to change{JobApplication.count}.by 0
        end
      end

      context 'position has no openings' do
        it "doesn't create a JobApplication" do
          expect {
            post :create, position_id: position_without_openings.id, job_application: attrs
          }.to change{JobApplication.count}.by 0
        end
      end

      context 'attr is blank' do
        let(:bad_attrs) { attrs.merge!(name: '') }

        it "doesn't create a JobApplication" do
          expect {
            post :create, position_id: position_with_openings.id, job_application: bad_attrs
          }.to change{JobApplication.count}.by 0
        end
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
