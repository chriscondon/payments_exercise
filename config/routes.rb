Rails.application.routes.draw do

  resources :loans, defaults: {format: :json}
  resources :payments, defaults: {format: :json}

  get "/loans/:id/payments", to: "loans#payments"
end
