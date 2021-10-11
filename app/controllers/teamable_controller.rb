# frozen_string_literal: true

class TeamableController < Teamable.config.parent_controller.constantize
  before_action :authenticate_account!
end
