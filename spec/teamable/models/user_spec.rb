# frozen_string_literal: true

require "spec_helper"

module Teamable
  module Models
    describe User, type: :model do
      it { should be_a ActiveSupport::Concern }

      context "when included on user" do
        let(:user) { create(:user) }

        it { expect(user).to be_valid }
        it { expect(user).to have_many(:members) }
        it { expect(user).to have_many(:accounts) }
        it { expect(user).to belong_to(:personal_account) }
      end
    end
  end
end
