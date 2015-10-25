class JobApplication < ActiveRecord::Base
  belongs_to :position

  validate :position_has_openings
  validates_presence_of :name, :phone, :email, :position_id

  [:resume, :cover_letter].each do |attachment|
    has_attached_file attachment
    validates_attachment attachment, { presence: true, content_type: { content_type: 'application/pdf' }}
  end

  def position_has_openings
    if !position.try(:has_openings?)
      errors.add(:position, I18n.t('flash.invalid_position_id'))
    end
  end
end
