# frozen_string_literal: true

module Teamable
  # Makes Teamable available to Rails as an Engine.
  class Engine < ::Rails::Engine
    initializer "teamable.setup" do
      # Make teamable helpers available in controllers.
      ActionController::Base.include Teamable::Controllers::Helpers
    end
  end
end
