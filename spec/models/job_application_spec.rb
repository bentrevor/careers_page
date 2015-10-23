require 'spec_helper'

describe JobApplication do
  it 'references a position' do
    position = Position.create(name: 'position')
    job_application = JobApplication.create(position: position)

    expect(job_application.position).to eq position
    expect(position.job_applications).to include job_application
  end
end
