Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords"
  },  path: "/", path_names: { sign_in: "login", sign_out: "logout", sign_up: "register" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Dashboard
  namespace :dashboard do
    root "home#index"
    resources :events do
      get "ticket_types", on: :member
      resources :tickets
    end
    resources :settings, only: [ :index, :edit, :update ]
    resources :orders
    resources :validators
  end

  # config/routes.rb

  namespace :validators do
    # Accès initial avec token
    get "login/:access_token", to: "login#show", as: :access

    # Dashboard principal
    namespace :dashboard do
      root to: "home#index", as: :home

      # Interface de scan/recherche de ticket
      get "tickets/scan", to: "tickets#new_scan", as: :new_scan_ticket

      # Consultation d’un ticket
      get "tickets", to: "tickets#show", as: :ticket

      # Validation d’un ticket
      put "tickets/:id/validate", to: "tickets#validate", as: :validate_ticket
    end
  end

  # Public Routes
  scope module: :public do
    resources :events, only: [ :index, :show ] do
      resources :tickets, only: [ :create ]

      resources :orders, only: [ :create ]
    end

    get "tickets/:token", to: "tickets#show"


    # resources :payments, only: [:index] do
    #   get 'confirmation', on: :member
    # end

    get "payments/:token", to: "payments#new", as: :new_payment
    post "payments/:token", to: "payments#create", as: :payment

    resources :accounts, only: [ :show ]
  end

  # Defines the root path route ("/")
  root "public/home#show"
end
