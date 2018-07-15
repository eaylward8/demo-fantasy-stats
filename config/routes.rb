# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  namespace :api, defaults: { format: :json } do
    resources :standings, only: [:index]
    resources :owners, only: [:show]
    get 'game_records/points_most', to: 'game_records#points_most'
    get 'game_records/points_least', to: 'game_records#points_least'
  end
end
