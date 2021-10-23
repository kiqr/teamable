# frozen_string_literal: true

require "rails/generators/base"
require "active_support/core_ext/string/inflections"

module Teamable
  module Generators
    class ViewsGenerator < Rails::Generators::Base
      desc "Copy view files to app/views"
      source_root Teamable::Engine.root

      def copy_views
        directory "app/views/teamable", "app/views/teamable"
      end
    end
  end
end
