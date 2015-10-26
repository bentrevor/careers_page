require 'spec_helper'

describe Position do
  let(:position_with_openings)    { FactoryGirl.create(:position_with_openings) }
  let(:position_without_openings) { FactoryGirl.create(:position_without_openings) }

  it 'knows if it has any openings' do
    expect(position_with_openings.has_openings?).to eq true
    expect(position_without_openings.has_openings?).to eq false
  end

  it 'has a scope for positions with openings' do
    expect(Position.with_openings).to include position_with_openings
    expect(Position.with_openings).not_to include position_without_openings
  end

  it 'has_many job_applications' do
    job_app = FactoryGirl.create(:job_application)
    position_with_openings.job_applications << job_app

    expect(position_with_openings.job_applications).to eq [job_app]
  end

  it 'validates a positive number of openings' do
    expect { FactoryGirl.create(:position, openings: -1) }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'validates presence of name' do
    expect { FactoryGirl.create(:position, name: '') }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
