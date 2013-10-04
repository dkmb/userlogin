Userlogin::Application.routes.draw do
  root 'users#index'
  resources :users
  get 'about' => 'home#about'
  get 'contact' => 'home#contact'
end
