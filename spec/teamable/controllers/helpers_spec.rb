# frozen_string_literal: true

require "spec_helper"

module Teamable
  module Controllers
    describe Helpers do
      let(:user) { create(:user) }

      it { should be_a ActiveSupport::Concern }

      context "when included in ApplicationController", type: :controller do
        before do
          @controller = ApplicationController.new
          sign_in(user)
          get :home
        end

        it "redirects to /account/setup if user have no accounts" do
          expect(response.body).to redirect_to("/account/setup")
        end
      end
    end
  end
end
