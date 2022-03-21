Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/nbp/:currency/:startDate/:endDate', to: 'nbp#currency_info'
end
