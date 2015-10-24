FactoryGirl.define do
  factory :job_application do
    position

    name 'applicant name'
    email 'applicant@email.com'
    phone '123-123-4567'
  end
end
