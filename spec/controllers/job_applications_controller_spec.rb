require 'spec_helper'

describe JobApplicationsController do
  let(:position_with_openings)    { FactoryGirl.create(:position_with_openings) }
  let(:position_without_openings) { FactoryGirl.create(:position_without_openings) }

  describe '#new' do
    context 'position with openings' do
      before do
        get :new, position_id: position_with_openings.id
      end

      it 'status == 200' do
        expect(response.status).to eq 200
      end

      it 'builds a JobApplication for a specific Position' do
        expect(assigns(:position)).to eq position_with_openings
        expect(assigns(:job_application)).to be_a JobApplication
      end
    end

    it "redirects to the careers page for a position_id that doesn't exist" do
      get :new, position_id: -1

      expect(response).to redirect_to careers_path
      expect(flash[:error]).to eq I18n.t('flash.invalid_position_id')
    end

    it "redirects back to the careers page for a Position that doesn't have openings" do
      get :new, position_id: position_without_openings

      expect(response).to redirect_to careers_path
      expect(flash[:error]).to eq I18n.t('flash.invalid_position_id')
    end
  end

  describe '#create' do
    let(:valid_attrs) {
      {
        name: 'name',
        phone: '123-123-4567',
        email: 'asdf@jkl.com',
        resume: fixture_file_upload('some_pdf.pdf', 'application/pdf'),
        cover_letter: fixture_file_upload('some_pdf.pdf', 'application/pdf'),
        position_id: position_id
      }
    }
    let(:valid_position_id) { position_with_openings.id }

    before do
      post :create, job_application: attrs
    end

    context 'with all valid attrs' do
      let(:attrs) { valid_attrs }
      let(:position_id) { valid_position_id }

      it 'creates a JobApplication' do
        expect(JobApplication.count).to eq 1

        job_app = JobApplication.last

        expect(job_app.name).to eq 'name'
        expect(job_app.phone).to eq '123-123-4567'
        expect(job_app.email).to eq 'asdf@jkl.com'
        expect(job_app.position).to eq position_with_openings
      end

      it 'redirects back to the job listings page with a flash message' do
        expect(flash[:success]).to eq I18n.t('flash.job_application_successfully_created', name: position_with_openings.name)
        expect(response).to redirect_to careers_path
      end
    end

    context "when position doesn't exist" do
      let(:attrs) { valid_attrs }
      let(:position_id) { -1 }

      it "doesn't create a JobApplication" do
        expect(JobApplication.count).to eq 0
      end

      it 'redirects to the job openings page with a flash message' do
        expect(response).to redirect_to careers_path
        expect(flash[:error]).to eq I18n.t('flash.invalid_position_id')
      end
    end

    context 'when position has no openings' do
      let(:attrs) { valid_attrs }
      let(:position_id) { position_without_openings.id }

      it "doesn't create a JobApplication" do
        expect(JobApplication.count).to eq 0
      end

      it 'redirects to the job openings page with a flash message' do
        expect(response).to redirect_to careers_path
        expect(flash[:error]).to eq I18n.t('flash.invalid_position_id')
      end
    end

    context 'when attr is blank' do
      let(:attrs) { valid_attrs.merge!(name: '') }
      let(:position_id) { valid_position_id }

      it "doesn't create a JobApplication" do
        expect(JobApplication.count).to eq 0
      end

      it 'redirects back to the application form with a flash message' do
        expect(response).to redirect_to new_job_application_path(position_with_openings.id)
        expect(flash[:error]).to include I18n.t('flash.invalid_attr')
        expect(flash[:error]).to include "Name can't be blank"
      end
    end

    context 'when cover letter or resume is missing' do
      let(:attrs) { valid_attrs.except(:resume) }
      let(:position_id) { valid_position_id }

      it "doesn't create a JobApplication" do
        expect(JobApplication.count).to eq 0
      end

      it 'redirects back to the application form with a flash message' do
        expect(response).to redirect_to new_job_application_path(position_with_openings.id)
        expect(flash[:error]).to include I18n.t('flash.invalid_attr')
        expect(flash[:error]).to include "Resume can't be blank"
      end
    end

    context 'when cover letter or resume is not a pdf' do
      let(:attrs) { valid_attrs.merge!(resume: fixture_file_upload('some_image.jpg', 'image/jpg')) }
      let(:position_id) { valid_position_id }

      it "doesn't create a JobApplication" do
        expect(JobApplication.count).to eq 0
      end

      it 'redirects back to the application form with a flash message' do
        expect(response).to redirect_to new_job_application_path(position_with_openings.id)
        expect(flash[:error]).to include I18n.t('flash.invalid_attr')
        expect(flash[:error]).to include 'Resume content type is invalid'
      end
    end

    context 'when user spoofs filetype' do
      let(:attrs) { valid_attrs.merge!(resume: fixture_file_upload('some_image.jpg', 'application/pdf')) }
      let(:position_id) { valid_position_id }

      it "doesn't trust the content_type" do
        expect(response).to redirect_to new_job_application_path(position_with_openings.id)
        expect(flash[:error]).to include I18n.t('flash.invalid_attr')
        expect(flash[:error]).to include 'Resume has contents that are not what they are reported to be'
      end
    end
  end

  # admin
  describe '#index' do
    before do
      get :index
    end

    it 'status == 200' do
      expect(response.status).to eq 200
    end

    it 'shows a list of all job applications' do
      3.times { |n| FactoryGirl.create(:job_application, name: n.to_s) }

      expect(assigns(:job_applications)).to eq JobApplication.all
    end
  end

  describe '#show' do
    let(:job_application) { FactoryGirl.create(:job_application) }
    let(:job_application_id) { job_application.id }

    before do
      get :show, id: job_application_id
    end

    it 'status == 200' do
      expect(response.status).to eq 200
    end

    it 'shows a single job application' do
      expect(assigns(:job_application)).to eq job_application
    end

    context 'invalid job application id' do
      let(:job_application_id) { -1 }

      it 'redirects home with a flash message for an invalid job application id' do
        expect(flash[:error]).to eq I18n.t('flash.invalid_job_application_id')
        expect(response).to redirect_to job_applications_path
      end
    end
  end
end
