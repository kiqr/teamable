# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  teamable "account" do
    root "application#home"
  end
end
