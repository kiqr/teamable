# frozen_string_literal: true

require "spec_helper"

RSpec.describe Teamable do
  it { expect(Teamable::VERSION).to be_truthy }

  describe "configuration default values" do
    it { expect(described_class.config.parent_controller).to eq("ApplicationController") }
    it { expect(described_class.config.email_regexp).to eq(/\A[^@\s]+@[^@\s]+\z/) }
  end
end
