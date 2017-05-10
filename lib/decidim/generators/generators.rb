#!/usr/bin/env ruby
require "rubygems" # ruby1.9 doesn't "require" it though
require "thor"

module Decidim
  module Generators
    class Generators < Thor
      include Thor::Actions

      attr_reader :engine_name, :engine_module_name, :engine_resource_name, :engine_folder

      def self.source_root
        File.dirname(__FILE__)
      end

      desc "engine ENGINE_NAME", "Generate a decidim engine"
      def engine(engine_name)
        @engine_name = engine_name
        @engine_module_name = engine_name.capitalize
        @engine_folder = "decidim-#{engine_name}"

        # decidim-engine/decidim-engine.gemspec
        template "templates/decidim-engine.gemspec.erb", "#{engine_folder}/decidim-#{engine_name}.gemspec"

        # decidim-engine/Rakefile
        template "templates/Rakefile", "#{engine_folder}/Rakefile"

        # decidim-engine/README.md
        template "templates/README.md.erb", "#{engine_folder}/README.md"

        # decidim-engine/app
        template "templates/app/assets/config/engine_manifest.css", "#{engine_folder}/app/assets/config/decidim_#{engine_name}_manifest.css"
        template "templates/app/assets/config/engine_manifest.js", "#{engine_folder}/app/assets/config/decidim_#{engine_name}_manifest.js"
        template "templates/app/assets/images/decidim/engine/icon.svg", "#{engine_folder}/app/assets/images/decidim/#{engine_name}/icon.svg"
        template "templates/app/controllers/decidim/engine/application_controller.rb.erb", "#{engine_folder}/app/controllers/decidim/#{engine_name}/application_controller.rb"
        template "templates/app/controllers/decidim/engine/admin/application_controller.rb.erb", "#{engine_folder}/app/controllers/decidim/#{engine_name}/admin/application_controller.rb"
        template "templates/app/helpers/decidim/engine/application_helper.rb.erb", "#{engine_folder}/app/helpers/decidim/#{engine_name}/application_helper.rb"
        template "templates/app/models/decidim/engine/application_record.rb.erb", "#{engine_folder}/app/models/decidim/#{engine_name}/application_record.rb"
        template "templates/app/models/decidim/engine/abilities/admin_user.rb.erb", "#{engine_folder}/app/models/decidim/#{engine_name}/abilities/admin_user.rb"
        template "templates/app/models/decidim/engine/abilities/process_admin_user.rb.erb", "#{engine_folder}/app/models/decidim/#{engine_name}/abilities/process_admin_user.rb"
        template "templates/app/models/decidim/engine/abilities/current_user.rb.erb", "#{engine_folder}/app/models/decidim/#{engine_name}/abilities/current_user.rb"

        # decidim-engine/bin
        template "templates/bin/rails.erb", "#{engine_folder}/bin/rails"

        # decidim-engine/config
        template "templates/config/locales/en.yml.erb", "#{engine_folder}/config/locales/en.yml"
        template "templates/config/i18n-tasks.yml.erb", "#{engine_folder}/config/i18n-tasks.yml"

        # decidim-engine/lib
        template "templates/lib/decidim/engine.rb.erb", "#{engine_folder}/lib/decidim/#{engine_name}.rb"
        template "templates/lib/decidim/engine/engine.rb.erb", "#{engine_folder}/lib/decidim/#{engine_name}/engine.rb"
        template "templates/lib/decidim/engine/admin.rb.erb", "#{engine_folder}/lib/decidim/#{engine_name}/admin.rb"
        template "templates/lib/decidim/engine/admin_engine.rb.erb", "#{engine_folder}/lib/decidim/#{engine_name}/admin_engine.rb"
        template "templates/lib/decidim/engine/feature.rb.erb", "#{engine_folder}/lib/decidim/#{engine_name}/feature.rb"
        template "templates/lib/decidim/engine/test/factories.rb.erb", "#{engine_folder}/lib/decidim/#{engine_name}/test/factories.rb"

        # decidim-engine/spec
        template "templates/spec/spec_helper.rb", "#{engine_folder}/spec/spec_helper.rb"
        template "templates/spec/factories.rb.erb", "#{engine_folder}/spec/factories.rb"    
      end
    end
  end
end
