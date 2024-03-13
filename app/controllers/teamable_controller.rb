# frozen_string_literal: true

class TeamableController < Teamable.config.parent_controller.constantize
  before_action :authenticate_user!
  before_action :authenticate_account!

  private

  def form_url_for_account(account)
    return update_account_path if account.persisted?
    account.personal_account ? setup_personal_account_path : account_path
  end
  helper_method :form_url_for_account

  def form_method_for_account(account)
    account.persisted? ? :patch : :post
  end
  helper_method :form_method_for_account
end
