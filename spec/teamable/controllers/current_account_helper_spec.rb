# frozen_string_literal: true

require "spec_helper"

module Teamable
  module Controllers
    describe CurrentAccountHelper do
      let(:user) { create(:user, :with_account) }

      it { should be_a ActiveSupport::Concern }

      context "when root, use personal account", type: :request do
        before do
          sign_in(user)
          get "/"
        end

        describe "#account_from_session" do
          it { expect(@controller.send(:current_account)).to eq(user.personal_account) }
        end
      end

      context "when prefixed path, use account id", type: :request do
        before do
          sign_in(user)
          get "/account/#{user.accounts.first.to_param}"
        end

        describe "#account_from_session" do
          it { expect(@controller.send(:current_account)).to eq(user.accounts.first) }
        end
      end
    end
  end
end
