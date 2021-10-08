# frozen_string_literal: true

require "spec_helper"

RSpec.describe Teamable do
  describe "teamable module" do
    it "loads version number" do
      expect(Teamable::VERSION).to be_truthy
    end
  end
end
