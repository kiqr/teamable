# frozen_string_literal: true

require "spec_helper"

module Teamable
  describe AccountsController, type: :controller do
    let(:user) { create(:user, :with_account) }

    before { sign_in(user) }

    it { expect(described_class.new.send(:teamable_controller?)).to eq(true) }
    it { should be_a Teamable.config.parent_controller.constantize }
    it { should be_a TeamableController }

    describe "PATCH /account/:id/switch" do
      before { patch :switch, params: { id: user.accounts.first.id } }

      it { expect(response).to have_http_status(:redirect) }
      it { expect(response).to redirect_to(root_path) }
    end
  end
end
