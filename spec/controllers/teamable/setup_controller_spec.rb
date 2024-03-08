# frozen_string_literal: true

require "spec_helper"

module Teamable
  describe SetupController, type: :request do
    let(:user) { create(:user) }

    before { sign_in(user) }

    it { expect(described_class.new.send(:teamable_controller?)).to be(true) }
    it { should be_a Teamable.config.parent_controller.constantize }
    it { should be_a TeamableController }

    describe "GET /onboarding/setup" do
      before { get "/onboarding/setup" }

      it { expect(response).to render_template(:new) }
      it { expect(response).to have_http_status(:success) }
      it { expect(response.body).to match(/account\[name\]/im) }
    end

    # describe "POST /users/sign_up" do
    context "when inputs are empty" do
      before { post "/onboarding/setup", params: { account: { name: nil } } }

      it { expect(response).to render_template(:new) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response.body).to match(/Name can&#39;t be blank/im) }
    end

    context "when inputs are valid" do
      let(:build_account) { build(:account) }

      before do
        post "/onboarding/setup", params: {
          account: { name: build_account.name }
        }
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to("/") }
    end
  end
end
