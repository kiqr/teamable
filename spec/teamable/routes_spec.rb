# frozen_string_literal: true

require "spec_helper"

module ActionDispatch
  module Routing
    describe Mapper, type: :request do
      it { expect(setup_account_path).to eq("/account/setup") }
    end
  end
end
