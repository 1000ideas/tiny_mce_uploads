class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :upload_file_name, :upload_content_type
      t.integer :upload_file_size
      t.datetime :upload_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
