require 'spec_helper'

describe JobApplication do
  let(:position) { FactoryGirl.create(:position) }
  let(:job_application) { FactoryGirl.create(:job_application, position: position) }

  it 'references a Position' do
    expect(job_application.position).to eq position
  end

  ['name', 'phone', 'email'].each do |attr|
    it "doesn't allow a blank #{attr}" do
      job_application.update_attribute(attr, '')

      expect { job_application.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
