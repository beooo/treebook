class Document < ActiveRecord::Base
  has_attached_file :attachment
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"]}
end
