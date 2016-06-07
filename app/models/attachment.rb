class Attachment < ActiveRecord::Base
  
  has_attached_file :upload, 
    :styles => {:original => "650x650>",  :large => "300x300>", :small => "100x100>", :thumb => "50x50" },
    :path => ":rails_root/public/system/uploads/:id/:style/:normalized_file_name",
    :url => "/system/uploads/:id/:style/:normalized_file_name"

  
  attr_accessible :upload

  before_post_process :image?
  
  validates_attachment_presence :upload
  validates_attachment_content_type :upload, :content_type => ['image/png', 'image/jpeg'], :if => :image?

  
  def image?
    if (upload_content_type =~ /^image/) == 0
      return true
    else
      false
    end
  end
    
  Paperclip.interpolates :normalized_file_name do |attachment, style|
    attachment.instance.normalized_file_name
  end

  def normalized_file_name
    "#{self.upload_file_name.gsub( /[^a-zA-Z0-9_\.]/, 'X')}" 
  end
  
end
