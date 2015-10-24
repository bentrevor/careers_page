class JobApplication < ActiveRecord::Base
  belongs_to :position

  validates_presence_of :name, :phone, :email

  [:resume, :cover_letter].each do |attachment|
    has_attached_file attachment
    validates_attachment attachment, { presence: true, content_type: { content_type: 'application/pdf' }}
  end
end
