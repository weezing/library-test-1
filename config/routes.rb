Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }
  root "home#index"
  resources :books do
    patch :borrow, on: :member
    patch :return, on: :member
    get :my_books, on: :collection
  end
end
