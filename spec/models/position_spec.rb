require 'spec_helper'

describe Position do
  it 'is open when there is at least one job_opening' do
    position_with_opening = Position.create(name: 'position with opening', openings: 1)
    position_without_opening = Position.create(name: 'position without opening', openings: 0)

    expect(Position.with_openings).to include position_with_opening
    expect(Position.with_openings).not_to include position_without_opening

    expect(position_with_opening).to have_openings
    expect(position_without_opening).not_to have_openings
  end

  it 'has_many job_applications' do
    position_with_opening = Position.create(name: 'position with opening', openings: 1)

    expect(position_with_opening.job_applications).to be_empty
  end
end
