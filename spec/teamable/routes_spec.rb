# frozen_string_literal: true

require "spec_helper"

module ActionDispatch
  module Routing
    describe Mapper, type: :request do
      it { expect(new_account_path).to eq("/organizations/new") }
    end
  end
end
