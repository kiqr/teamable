# frozen_string_literal: true

require "spec_helper"

module Teamable
  module Controllers
    describe CurrentAccountHelper do
      let(:user) { create(:user, :with_account) }

      it { should be_a ActiveSupport::Concern }

      context "when session id is set", type: :request do
        before do
          sign_in(user)
          patch "/account/#{user.accounts.first.id}/switch"
          get "/"
        end

        describe "#account_from_session" do
          it { expect(@controller.send(:account_from_session)).to eq(user.accounts.first) }
        end
      end
    end
  end
end
