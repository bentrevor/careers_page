class JobApplication < ActiveRecord::Base
  belongs_to :position

  validates :name, presence: true
  validates :phone, presence: true
  validates :email, presence: true
end
