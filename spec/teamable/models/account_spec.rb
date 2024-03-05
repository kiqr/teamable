# frozen_string_literal: true

require "spec_helper"

module Teamable
  module Models
    describe Account, type: :model do
      it { should be_a ActiveSupport::Concern }

      context "when included on account" do
        let(:user) { create(:user, :with_account) }
        let(:account) { user.accounts.first }

        it { expect(account).to be_valid }
        it { expect(account).to have_many(:members) }
        it { expect(account).to have_many(:users) }
        it { expect(account).to validate_presence_of(:name) }
      end
    end
  end
end
