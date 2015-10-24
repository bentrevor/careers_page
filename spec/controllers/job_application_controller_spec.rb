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
    let(:attrs) {
      {
        name: 'name',
        phone: '123-123-4567',
        email: 'asdf@jkl.com',
        resume: fixture_file_upload('some_pdf.pdf', 'application/pdf'),
        cover_letter: fixture_file_upload('some_pdf.pdf', 'application/pdf')
      }
    }

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

      it 'redirects back to the job listings page' do
        post :create, position_id: position_with_openings.id, job_application: attrs

        expect(response).to redirect_to careers_path
      end

      it 'shows a "success" flash message' do
        post :create, position_id: position_with_openings.id, job_application: attrs

        expect(flash[:success]).to include position_with_openings.name
      end
    end

    describe 'invalid attr' do
      context "position doesn't exist" do
        it "doesn't create a JobApplication" do
          expect {
            post :create, position_id: 'asdf', job_application: attrs
          }.to change{JobApplication.count}.by 0
        end

        it 'redirects to the job openings page with a flash message' do
          post :create, position_id: 'asdf', job_application: attrs

          expect(response).to redirect_to careers_path
          expect(flash[:error]).not_to be_nil
        end
      end

      context 'position has no openings' do
        it "doesn't create a JobApplication" do
          expect {
            post :create, position_id: position_without_openings.id, job_application: attrs
          }.to change{JobApplication.count}.by 0
        end

        it 'redirects to the job openings page with a flash message' do
          post :create, position_id: position_without_openings.id, job_application: attrs

          expect(response).to redirect_to careers_path
          expect(flash[:error]).to include position_without_openings.name
        end
      end

      context 'attr is blank' do
        let(:bad_attrs) { attrs.merge!(name: '') }

        it "doesn't create a JobApplication" do
          expect {
            post :create, position_id: position_with_openings.id, job_application: bad_attrs
          }.to change{JobApplication.count}.by 0
        end

        # in case the js validation doesn't catch it
        it 'redirects back to the application form with a flash message' do
          post :create, position_id: position_with_openings.id, job_application: bad_attrs

          expect(response).to redirect_to job_applications_path(position_with_openings.id)
          expect(flash[:error]).to include 'Name'
        end
      end

      context 'cover letter or resume is missing' do
        let(:bad_attrs) { attrs.except(:resume) }

        it "doesn't create a JobApplication" do
          expect {
            post :create, position_id: position_with_openings.id, job_application: bad_attrs
          }.to change{JobApplication.count}.by 0
        end
      end
    end
  end
end
