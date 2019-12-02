Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin do
    
    resources :dislu_sliders
    
    resource :dislu_settings


  end

  get '/dislu_cart_link', to: 'store#dislu_cart_link', as: :dislu_cart_link
  
end
