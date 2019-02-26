RailsSandbox::Application.routes.draw do
  # Album 
  constraints(secret: /([a-z]|[0-9]){32}/) do
    # This is stupid. Because I am not using ID but secret 
    # I have to redefine all my routes
    patch 'albums/upload_images'
    post 'albums/download/:secret',  to: 'albums#download'
    get ":secret" => "albums#show"
    resources :albums
  end
  # Images
  resources :image
  
  # User
  resources :user, as: "users" do
    collection do
      get 'logout'
      get 'login'
      post 'login'
    end
  end

  # Password reminder
  constraints(:secret => /([a-z]|[0-9]){32}/) do
    get "password_reminders/:secret", to: "password_reminders#show"
    resources :password_reminders
  end

  # Root
  root to: 'albums#index'
  get 'profile',  to: 'albums#user_profile'
end
