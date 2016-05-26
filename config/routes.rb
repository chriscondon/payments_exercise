Rails.application.routes.draw do
  get 'payments/index'

  get 'payments/show'

  get 'payments/create'

  resources :loans, defaults: {format: :json}
end
