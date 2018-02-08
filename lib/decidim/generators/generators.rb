#!/usr/bin/env ruby
require "thor"
require "active_support/inflector"
require "decidim/version"

module Decidim
  module Generators
    class Generators < Thor
      include Thor::Actions

      attr_reader :engine_name, :engine_module_name, :engine_resource_name, :engine_folder, :core_version

      def self.source_root
        File.dirname(__FILE__)
      end

      desc "engine ENGINE_NAME", "Generate a decidim engine"

      method_options destination_folder: :string, gemfile: :boolean

      def engine(engine_name)
        @engine_name = engine_name
        @engine_module_name = engine_name.camelize
        @engine_folder = options[:destination_folder] || "decidim-module-#{engine_name}"
        @core_version = Decidim.version

        template "templates/decidim-engine.gemspec.erb", "#{engine_folder}/decidim-#{engine_name}.gemspec"

        template "templates/Gemfile.erb", "#{engine_folder}/Gemfile" if options[:gemfile]

        template "templates/Rakefile", "#{engine_folder}/Rakefile"

        template "templates/README.md.erb", "#{engine_folder}/README.md"

        app_folder = "#{engine_folder}/app"
        template "templates/app/assets/config/engine_manifest.css", "#{app_folder}/assets/config/decidim_#{engine_name}_manifest.css"
        template "templates/app/assets/config/engine_manifest.js", "#{app_folder}/assets/config/decidim_#{engine_name}_manifest.js"
        template "templates/app/assets/images/decidim/engine/icon.svg", "#{app_folder}/assets/images/decidim/#{engine_name}/icon.svg"
        template "templates/app/controllers/decidim/engine/application_controller.rb.erb", "#{app_folder}/controllers/decidim/#{engine_name}/application_controller.rb"
        template "templates/app/controllers/decidim/engine/admin/application_controller.rb.erb", "#{app_folder}/controllers/decidim/#{engine_name}/admin/application_controller.rb"
        template "templates/app/helpers/decidim/engine/application_helper.rb.erb", "#{app_folder}/helpers/decidim/#{engine_name}/application_helper.rb"
        template "templates/app/models/decidim/engine/application_record.rb.erb", "#{app_folder}/models/decidim/#{engine_name}/application_record.rb"
        template "templates/app/models/decidim/engine/abilities/admin_user.rb.erb", "#{app_folder}/models/decidim/#{engine_name}/abilities/admin_user.rb"
        template "templates/app/models/decidim/engine/abilities/process_admin_user.rb.erb", "#{app_folder}/models/decidim/#{engine_name}/abilities/process_admin_user.rb"
        template "templates/app/models/decidim/engine/abilities/current_user.rb.erb", "#{app_folder}/models/decidim/#{engine_name}/abilities/current_user.rb"

        template "templates/bin/rails.erb", "#{engine_folder}/bin/rails"

        config_folder = "#{engine_folder}/config"
        template "templates/config/locales/en.yml.erb", "#{config_folder}/locales/en.yml"
        template "templates/config/i18n-tasks.yml.erb", "#{config_folder}/i18n-tasks.yml"

        lib_folder = "#{engine_folder}/lib"
        template "templates/lib/decidim/engine.rb.erb", "#{lib_folder}/decidim/#{engine_name}.rb"
        template "templates/lib/decidim/engine/engine.rb.erb", "#{lib_folder}/decidim/#{engine_name}/engine.rb"
        template "templates/lib/decidim/engine/admin.rb.erb", "#{lib_folder}/decidim/#{engine_name}/admin.rb"
        template "templates/lib/decidim/engine/admin_engine.rb.erb", "#{lib_folder}/decidim/#{engine_name}/admin_engine.rb"
        template "templates/lib/decidim/engine/feature.rb.erb", "#{lib_folder}/decidim/#{engine_name}/feature.rb"
        template "templates/lib/decidim/engine/version.rb.erb", "#{lib_folder}/decidim/#{engine_name}/version.rb"
        template "templates/lib/decidim/engine/test/factories.rb.erb", "#{lib_folder}/decidim/#{engine_name}/test/factories.rb"

        spec_folder = "#{engine_folder}/spec"
        template "templates/spec/spec_helper.rb", "#{spec_folder}/spec_helper.rb"
        template "templates/spec/factories.rb.erb", "#{spec_folder}/factories.rb"
      end
    end
  end
end
