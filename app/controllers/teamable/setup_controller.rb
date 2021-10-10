# frozen_string_literal: true

module Teamable
  class SetupController < TeamableController
    def new
      @account = current_user.accounts.new
    end

    def create
      @account = current_user.accounts.build(account_params)
      @account.members.build(user: current_user)

      if @account.save
        redirect_to root_path, notice: "success"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :billing_email)
    end
  end
end
