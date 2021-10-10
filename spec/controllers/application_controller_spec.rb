# frozen_string_literal: true

require "spec_helper"

describe ApplicationController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in(user)
    get :home
  end

  it "redirects to /account/setup if user have no accounts" do
    expect(response.body).to redirect_to("/account/setup")
  end
end
