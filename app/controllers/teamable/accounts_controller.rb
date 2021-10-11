# frozen_string_literal: true

module Teamable
  class AccountsController < TeamableController
    skip_before_action :authenticate_account!, only: %i[switch]

    def switch
      _account = current_user.accounts.find(params[:id])
      # session[:teamable_account_id] = account.id
      redirect_to after_account_switched_path
    end

    private

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :billing_email)
    end
  end
end
