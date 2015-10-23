class Position < ActiveRecord::Base
  has_many :job_applications

  # `open` shadows some private method...
  scope :with_openings, -> { where('openings > 0') }

  def has_openings?
    openings > 0
  end
end
