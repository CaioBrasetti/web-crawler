Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get 'scrape_quotes', to: 'crawlers#scrape_quotes'

  # Defines the root path route ("/")
  # root "posts#index"

  require "sidekiq/web"
  require "sidekiq/cron/web"

  # authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  # end
end
