Rails.application.routes.draw do
  resources :twilio do
    collection do
      post 'voice'
      post 'reply_text'
      get 'sms_quickstart'
    end
  end

  post 'twilio/voice' => 'twilio#voice'
  
  get 'checkin' => 'attendances#new'
  post 'attendances/create'

  resources :events do
    member do
      get 'confirm_checkin'
      delete 'cancel_checkin'
    end
  end

  get 'welcome/index'
  root 'welcome#index'
  resources :users, only: [:show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
