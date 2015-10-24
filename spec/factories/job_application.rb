FactoryGirl.define do
  factory :job_application do
    position

    name 'applicant name'
    email 'applicant@email.com'
    phone '123-123-4567'

    # TODO figure out how to stub these...
    resume File.new(Rails.root + 'spec/fixtures/ben-trevor_resume.pdf')
    cover_letter File.new(Rails.root + 'spec/fixtures/ben-trevor_cover-letter.pdf')
  end
end
