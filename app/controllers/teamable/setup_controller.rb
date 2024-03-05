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
        update_teamable_session_id!(@account.id)
        redirect_to root_path, notice: "Your account was setup successfully!"
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
