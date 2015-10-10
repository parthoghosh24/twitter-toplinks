Rails.application.routes.draw do




  #sessions controller
  get '/auth/:provider/callback', to:'sessions#create'
  delete '/sessions/delete', to:"sessions#destroy", as: :logout

  #analytics controller
  root to:'analytics#index'
  get 'analytics/tweets', to:'analytics#fetch_link_tweets'
  get 'analytics/topuser', to:'analytics#top_user'
  get 'analytics/topdomains', to:'analytics#top_domains'

end
