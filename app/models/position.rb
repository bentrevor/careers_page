class Position < ActiveRecord::Base
  has_many :job_applications

  scope :with_openings, -> { where('openings > 0') }

  validates_presence_of :name
  validates :openings, numericality: { greater_than_or_equal_to: 0 }

  def has_openings?
    openings > 0
  end
end
