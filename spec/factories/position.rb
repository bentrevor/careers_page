FactoryGirl.define do
  factory :position, aliases: [:position_with_openings] do
    name 'factory position'
    description 'factory position description'
    openings 5

    factory :position_without_openings do
      openings 0
    end
  end
end
