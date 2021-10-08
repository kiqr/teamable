# frozen_string_literal: true

Rails.application.routes.draw do
  authenticatable :users
  authenticatable :admins, skip: :registrations

  # Unused routes for testing the route mapper.
  authenticatable :users_without_scope, path: ""
  authenticatable :username_users, path: ""
  authenticatable :followers, skip: :sessions, path_names: { sign_out: "logout" }
  authenticatable :members, path_names: { sign_in: "login", sign_up: "register", sign_out: "logout" }
  authenticatable :subscribers, controllers: { sessions: "subscribers/sessions",
                                               registrations: "subscribers/registrations" }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#home"
end
