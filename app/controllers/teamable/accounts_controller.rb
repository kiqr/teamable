# frozen_string_literal: true

module Teamable
  class AccountsController < TeamableController
    skip_before_action :authenticate_account!, only: %i[new create switch]

    # GET /account/new
    def new
      @account = current_user.accounts.new
    end

    # POST /account
    def create
      @account = current_user.accounts.build(account_params)
      @account.members.build(user: current_user)

      if @account.save
        redirect_to root_path(account_id: @account)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def switch
      account = current_user.accounts.find_puid!(params[:id])
      redirect_to after_account_switched_path(account)
    end

    private

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name)
    end
  end
end
