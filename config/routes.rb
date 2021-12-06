Spree::Core::Engine.routes.draw do
  resources :feedbacks
  namespace :admin do
    resources :feedbacks do
      member do
        put :approve
        put :reject
      end
    end
  end
end
