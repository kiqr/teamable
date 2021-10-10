# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :authenticate_account!

  def home
    render html: "", status: :ok
  end
end
