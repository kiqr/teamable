# frozen_string_literal: true

module Teamable
  class SetupController < TeamableController
    # GET /account/setup
    def new
      @account = current_user.accounts.new(billing_email: current_user.email)
    end

    # POST /account/setup
    def create
      @account = current_user.accounts.build(account_params)
      @account.members.build(user: current_user)

      if @account.save
        update_teamable_session_id!(@account.id)
        redirect_to root_path, notice: "#{@account.name} was setup successfully!"
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
