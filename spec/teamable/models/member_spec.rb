# frozen_string_literal: true

require "spec_helper"

module Teamable
  module Models
    describe Member, type: :model do
      it { should be_a ActiveSupport::Concern }

      context "when included on account" do
        let(:user) { create(:user, :with_account) }
        let(:member) { user.members.first }

        it { expect(member).to be_valid }
        it { expect(member).to belong_to(:user) }
        it { expect(member).to belong_to(:account) }
        it { expect(member).to validate_presence_of(:role) }

        it { expect(member).to allow_values("valid@mail.com").for(:invitee_email) }
        it { expect(member).not_to allow_values("invalid.com").for(:invitee_email) }

        it { expect(member.role).to eq(::Member::FIRST_USER_ROLE) }
        it { expect(member.role_name).to eq(::Member::FIRST_USER_ROLE.capitalize) }
        it { expect(member.role?(:admin)).to eq(true) }
        it { expect(member.role?("admin")).to eq(true) }
      end
    end
  end
end
