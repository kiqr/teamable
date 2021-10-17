# frozen_string_literal: true

require "spec_helper"

module Teamable
  describe AccountsController, type: :request do
    let(:user) { create(:user, :with_account) }

    before { sign_in(user) }

    it { expect(described_class.new.send(:teamable_controller?)).to eq(true) }
    it { should be_a Teamable.config.parent_controller.constantize }
    it { should be_a TeamableController }

    describe "PATCH /account/:id/switch" do
      before { patch "/account/#{user.accounts.first.id}/switch" }

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(root_path) }
    end

    describe "GET /account/setup" do
      before { get "/account/new" }

      it { expect(response).to render_template(:new) }
      it { expect(response).to have_http_status(:success) }
      it { expect(response.body).to match(/account\[name\]/im) }
      it { expect(response.body).to match(/account\[billing_email\]/im) }
    end

    # describe "POST /users/sign_up" do
    context "when inputs are empty" do
      before { post "/account", params: { account: { name: nil, billing_email: nil } } }

      it { expect(response).to render_template(:new) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
      it { expect(response.body).to match(/Name can&#39;t be blank/im) }
      it { expect(response.body).to match(/Billing email can&#39;t be blank/im) }
    end

    context "when inputs are valid" do
      let(:build_account) { build(:account) }

      before do
        post "/account", params: {
          account: { name: build_account.name,
                     billing_email: build_account.billing_email }
        }
      end

      it { expect(response).to have_http_status(:found) }
      it { expect(response).to redirect_to("/") }
    end
  end
end
