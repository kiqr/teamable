# frozen_string_literal: true

TMP_GENERATORS_DIR = File.expand_path("../../tmp", __dir__)

def create_routes_file_helper
  FileUtils.mkdir File.join([TMP_GENERATORS_DIR, "config"])
  FileUtils.touch File.join([TMP_GENERATORS_DIR, "config/routes.rb"])
  system "echo 'Rails.application.routes.draw do\n  authenticatable :users\nend' >> #{File.join([TMP_GENERATORS_DIR,
    "config/routes.rb"])}"
end

def create_dummy_user_helper
  FileUtils.mkdir_p File.join([TMP_GENERATORS_DIR, "app/models"])
  model_contents = 'class User < ActiveRecord::Base\n  authenticatable  \nend'
  system "echo '#{model_contents}' >> #{File.join([TMP_GENERATORS_DIR, "app/models/user.rb"])}"
end
