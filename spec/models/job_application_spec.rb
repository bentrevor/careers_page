require 'spec_helper'

describe JobApplication do
  let(:position) { FactoryGirl.create(:position) }
  let(:job_application) { FactoryGirl.create(:job_application, position: position) }

  it 'references a Position' do
    expect(job_application.position).to eq position
  end

  it 'validates that the Position has openings on creation' do
    position = FactoryGirl.create(:position_without_openings)
    invalid_job_application = FactoryGirl.build(:job_application, position: position)

    expect(invalid_job_application.save).to be false
  end

  [:name, :phone, :email, :position_id].each do |attr|
    it "doesn't allow a blank #{attr}" do
      job_application.update_attribute(attr, '')

      expect { job_application.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'attachments' do
    it 'has attachments for resume and cover letter' do
      expect(job_application).to have_attached_file(:resume)
      expect(job_application).to have_attached_file(:cover_letter)
    end

    it 'validates presence of resume' do
      job_application.resume = nil

      expect { job_application.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validates presence of cover_letter' do
      job_application.cover_letter = nil

      expect { job_application.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validates that the attachments are PDFs' do
      expect(job_application).to validate_attachment_content_type(:resume).allowing('application/pdf')
      expect(job_application).to validate_attachment_content_type(:cover_letter).allowing('application/pdf')
    end
  end
end
