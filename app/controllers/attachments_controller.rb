AttachmentsController = Class.new(TinyMceUploads.attachments_controller_superclass_name.constantize) do
  layout false
  def list
    photos = Attachment.all.collect{|tp| { :large => tp.upload.url(:large), 
                                             :small => tp.upload.url(:small), 
                                             :thumb => tp.upload.url(:thumb), 
                                             :original => tp.upload.url } }
    respond_to do |format|
      format.json { render :json => photos }
      format.xml { render :xml => photos }
    end
  end
  
  def upload
    Attachment.create(params[:attachment])
    redirect_to :back
  end
  
  def delete
    if current_user.has_role?(:admin)
      params[:path] =~ /uploads\/([0-9]*)\//i
      Attachment.find($1.to_i).destroy
    end
    redirect_to :back
  end
end
