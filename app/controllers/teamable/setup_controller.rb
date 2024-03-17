# frozen_string_literal: true

module Teamable
  class SetupController < TeamableController
    # GET /account/setup
    def new
      @account = current_user.build_personal_account(
        personal_account: true
      )
    end

    # POST /account/setup
    def create
      @account = current_user.build_personal_account(account_params)
      @account.personal_account = true
      @account.members.build(user: current_user)

      if @account.save
        current_user.update(personal_account: @account)
        redirect_to after_account_switched_path(@account), notice: "Your account was setup successfully!"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name)
    end
  end
end
