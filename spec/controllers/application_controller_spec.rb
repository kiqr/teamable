# frozen_string_literal: true

require "spec_helper"

describe ApplicationController, type: :request do
  let(:user) { create(:user) }
  let(:user_with_account) { create(:user, :with_account) }

  it "redirects to /onboarding/setup if user have no accounts" do
    sign_in(user)
    get "/"
    expect(response.body).to redirect_to("/onboarding/setup")
  end

  it "stays on page if user have account(s)" do
    sign_in(user_with_account)
    get "/"
    expect(response).to have_http_status(:ok)
  end
end
