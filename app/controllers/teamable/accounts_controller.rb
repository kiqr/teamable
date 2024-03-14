# frozen_string_literal: true

module Teamable
  class AccountsController < TeamableController
    skip_before_action :authenticate_account!, only: %i[new create switch]
    before_action :setup_account, only: %i[edit update]

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

    def edit
    end

    def update
      if @account.update(account_params)
        redirect_to edit_account_path, notice: "Account was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def switch
      account = current_user.accounts.find_puid!(params[:account_id])
      redirect_to after_account_switched_path(account)
    end

    private

    def setup_account
      # Use current_account instead of params[:account_id] since the param is not present for personal accounts.
      # We still want to fetch the account again to make sure it's separated from current_account used on
      # other places in the app, for example in the toolbar.
      @account = current_user.accounts.find(current_account&.id)
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name)
    end
  end
end
