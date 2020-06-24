Rails.application.routes.draw do

  devise_for :customers
  devise_for :admins, controllers: { sessions: 'admins/sessions' }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pages#home"
  get 'events/new_ticket_type', to: "events#new_ticket_type", as: :new_event_ticket_type_otf

  resources :events do
    resources :ticket_types, shallow: true
  end

  resource :customer, only: [:show] do
    resources :orders, only: [:show, :index, :destroy], shallow: true do
      resources :tickets, only: [:show, :index], shallow: true
    end
  end
  resource :shopping_cart, only: [:show]

  post 'shopping_cart/add/:ticket_type_id', to: "shopping_cart#add"
  post 'shopping_cart/remove/:ticket_type_id', to: "shopping_cart#remove"
  match 'shopping_cart/zap', to: "shopping_cart#zap", via: [:post, :get]
  match 'search', to: "search#search", via: [:post, :get]
end
