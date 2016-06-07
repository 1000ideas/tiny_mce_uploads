Rails.application.routes.draw do
  scope '/tiny_mce_uploads' do
    resources :attachments do 
      collection do
        get :list
        get :delete
        post :upload
      end
    end
  end
end
