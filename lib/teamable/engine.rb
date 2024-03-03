# frozen_string_literal: true

module Teamable
  # Makes Teamable available to Rails as an Engine.
  class Engine < ::Rails::Engine
    initializer "teamable.setup" do
      # Make teamable helpers available in controllers.
      ActiveSupport.on_load(:action_controller) { include Teamable::Controllers::CurrentAccountHelper }
      ActiveSupport.on_load(:action_controller) { include Teamable::Controllers::UrlHelpers }
    end
  end
end
