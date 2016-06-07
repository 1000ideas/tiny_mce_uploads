# encoding: utf-8
module TinyMceUploads
  AttachmentsController = Class.new(TinyMceUploads.attachments_controller_superclass_name.constantize) do
    
    layout false
    
    def list
      @photos = Attachment.order('created_at DESC')
      
      respond_to do |format|
        format.html { }
        format.json { render :json => @photos }
        format.xml { render :xml => @photos }
      end
    end
    
    def upload
      @attachment = Attachment.new(params[:attachment])
      if @attachment.save
        redirect_to :back, :notice => 'Dodano plik'
      else
        redirect_to :back, :notice => @attachment.errors.full_messages.first
      end  
    end
    
    def delete
      if current_user and current_user.has_role?(:admin)
        Attachment.find(params[:id]).destroy
      end
      redirect_to :back, :notice => 'Plik został usunięty'
    end
  end
end
