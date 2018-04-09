#!/usr/bin/env ruby
# frozen_string_literal: true

require "thor"
require "active_support/inflector"
require "decidim/version"

module Decidim
  module Generators
    class Generators < Thor
      include Thor::Actions

      attr_reader :engine_name, :engine_module_name, :engine_resource_name, :engine_folder, :engine_description, :core_version

      def self.source_root
        File.dirname(__FILE__)
      end

      desc "engine ENGINE_NAME", "Generate a decidim engine"

      method_options destination_folder: :string, external: :boolean

      def engine(engine_name)
        @engine_name = engine_name
        @engine_module_name = engine_name.camelize
        @engine_folder = options[:destination_folder] || "decidim-module-#{engine_name}"
        @core_version = Decidim.version
        @engine_description = ask "Write a description for the new component:"

        template "templates/decidim-engine.gemspec.erb", "#{engine_folder}/decidim-#{engine_name}.gemspec"
        template "templates/Gemfile.erb", "#{engine_folder}/Gemfile" if options[:external]
        template "templates/Rakefile", "#{engine_folder}/Rakefile"
        template "templates/README.md.erb", "#{engine_folder}/README.md"
        template "templates/.rubocop.yml", "#{engine_folder}/.rubocop.yml"
        template "templates/.gitignore", "#{engine_folder}/.gitignore"
        template "templates/.circleci/config.yml", "#{engine_folder}/.circleci/config.yml"

        app_folder = "#{engine_folder}/app"
        template "templates/app/assets/config/engine_manifest.css", "#{app_folder}/assets/config/decidim_#{engine_name}_manifest.css"
        template "templates/app/assets/config/engine_manifest.js", "#{app_folder}/assets/config/decidim_#{engine_name}_manifest.js"
        template "templates/app/assets/images/decidim/engine/icon.svg", "#{app_folder}/assets/images/decidim/#{engine_name}/icon.svg"
        template "templates/app/controllers/decidim/engine/application_controller.rb.erb", "#{app_folder}/controllers/decidim/#{engine_name}/application_controller.rb"
        template "templates/app/controllers/decidim/engine/admin/application_controller.rb.erb", "#{app_folder}/controllers/decidim/#{engine_name}/admin/application_controller.rb"
        template "templates/app/helpers/decidim/engine/application_helper.rb.erb", "#{app_folder}/helpers/decidim/#{engine_name}/application_helper.rb"
        template "templates/app/models/decidim/engine/application_record.rb.erb", "#{app_folder}/models/decidim/#{engine_name}/application_record.rb"
        template "templates/app/models/decidim/engine/abilities/admin/admin_ability.rb.erb", "#{app_folder}/models/decidim/#{engine_name}/abilities/admin/admin_ability.rb"
        template "templates/app/models/decidim/engine/abilities/current_user_ability.rb.erb", "#{app_folder}/models/decidim/#{engine_name}/abilities/current_user_ability.rb"

        bin_folder = "#{engine_folder}/bin"
        template "templates/bin/rails.erb", "#{bin_folder}/rails"
        chmod "#{bin_folder}/rails", "+x"

        config_folder = "#{engine_folder}/config"
        template "templates/config/locales/en.yml.erb", "#{config_folder}/locales/en.yml"
        template "templates/config/i18n-tasks.yml.erb", "#{config_folder}/i18n-tasks.yml"

        lib_folder = "#{engine_folder}/lib"
        template "templates/lib/decidim/engine.rb.erb", "#{lib_folder}/decidim/#{engine_name}.rb"
        template "templates/lib/decidim/engine/engine.rb.erb", "#{lib_folder}/decidim/#{engine_name}/engine.rb"
        template "templates/lib/decidim/engine/admin.rb.erb", "#{lib_folder}/decidim/#{engine_name}/admin.rb"
        template "templates/lib/decidim/engine/admin_engine.rb.erb", "#{lib_folder}/decidim/#{engine_name}/admin_engine.rb"
        template "templates/lib/decidim/engine/component.rb.erb", "#{lib_folder}/decidim/#{engine_name}/component.rb"
        template "templates/lib/decidim/engine/version.rb.erb", "#{lib_folder}/decidim/#{engine_name}/version.rb"
        template "templates/lib/decidim/engine/test/factories.rb.erb", "#{lib_folder}/decidim/#{engine_name}/test/factories.rb"

        spec_folder = "#{engine_folder}/spec"
        template "templates/spec/spec_helper.rb.erb", "#{spec_folder}/spec_helper.rb"
        template "templates/spec/factories.rb.erb", "#{spec_folder}/factories.rb"

        if options[:external]
          inside(engine_folder) do
            Bundler.with_original_env { run "bundle install" }
          end
        end
      end
    end
  end
end
