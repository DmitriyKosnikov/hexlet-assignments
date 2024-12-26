# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  root 'Home#index'
  get 'Pages/show'
  # END
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
