require "generators/rocky/resource_helpers"

module Rocky
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rocky::Generators::ResourceHelpers

      source_root File.expand_path("../templates", __FILE__)

      desc "This generator installs Rocky Middleware in app/assets/javascripts/application"

      class_option :skip_git, :type => :boolean, :aliases => "-G", :default => false,
                   :desc => "Skip Git ignores and keeps"

      def inject_middleware
        inject_into_file "app/assets/javascripts/application.js", :after => "//= require jquery_ujs" do
          "\n//= require underscore\n//= require backbone\n//= require xdomain\n//= require middleware\n//= require application/#{application_name.underscore}"
        end
      end

      def create_dir_layout
        %W{models views}.each do |dir|
          empty_directory "app/assets/javascripts/application/#{dir}"
          create_file "app/assets/javascripts/application/#{dir}/.gitkeep" unless options[:skip_git]
        end
      end

      def create_app_file
        template "app.coffee", "app/assets/javascripts/application/#{application_name.underscore}.js.coffee"
      end
    end
  end
end