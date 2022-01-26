# frozen_string_literal: true

require 'rails/engine'

module Cherrystone
  class << self
    def configure
      yield Engine.config
    end
  end

  class Engine < ::Rails::Engine
    config.renderer = nil
    config.enhance_exceptions = true
    config.inheritable_options = [:edit]
    config.default_node_class = 'Cherrystone::Node::Base'
    config.custom_node_class_lookup = nil

    isolate_namespace Cherrystone

    config.after_initialize do
      #
      # Create root DSL methods
      #
      Cherrystone::ViewHelper.cherrystone_helper(
        collection_table: Cherrystone::Node::CollectionTable,
        detail_view: Cherrystone::Node::DetailView,
        custom_form: Cherrystone::Node::CustomForm
      )

      ActiveSupport.run_load_hooks :cherrystone

      Cherrystone::DslCaller.enhance_exceptions if config.enhance_exceptions
    end

  end
end
