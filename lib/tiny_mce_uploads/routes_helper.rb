module TinyMceUploads
  module RoutesHelper
    def tinymce_upload(name = 'tiny_mce_uploads', options = {})
      valid_options = options.slice(:controller)

      scope name do
        match 'attachments/list(.:format)', {
            controller: 'tiny_mce_uploads/attachments',
            action: 'list',
            via: :get,
            as: :attachments_list
          }.merge(valid_options)

        match 'attachments/:id/delete', {
            controller: 'tiny_mce_uploads/attachments',
            action: 'delete',
            via: :get,
            as: :attachment_delete
          }.merge(valid_options)

        match 'attachments/upload', {
            controller: 'tiny_mce_uploads/attachments',
            action: 'upload',
            via: :post,
            as: :attachment_upload
          }.merge(valid_options)
      end
    end
    
  end
end

ActionDispatch::Routing::Mapper.send(:include, TinyMceUploads::RoutesHelper)