# frozen_string_literal: true

require "spec_helper"

module ActionDispatch
  module Routing
    describe Mapper, type: :request do
      let(:user) { create(:user, :with_account) }

      it { expect(setup_personal_account_path).to eq("/onboarding/setup") }
      it { expect(root_path(account_id: user.accounts.first)).to eq("/account/#{user.accounts.first.public_uid}") }
    end
  end
end
