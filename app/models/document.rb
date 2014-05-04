class Document < ActiveRecord::Base
  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"]}




  attr_accessor :remove_attachment

  before_save :perfrom_attachment_removal

  def perfrom_attachment_removal
    if remove_attachment == '1' && !attachment.dirty?
      self.attachment = nil
    end
  end

end
