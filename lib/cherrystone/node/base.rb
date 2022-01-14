# frozen_string_literal: true

module Cherrystone
  class Node::Base < Node

    def self.settings(*keys)
      keys.each do |setting|
        define_method setting do |value=nil|
          value = true if value.nil?
          instance_variable_set("@#{setting}", value)
        end

        define_method "#{setting}?" do
          !!instance_variable_get("@#{setting}")
        end
      end
    end

    singleton_class.alias_method :setting, :settings

    #
    # Generic DSL methods for all subclasses
    #

    def title(value)
      append :title, value
    end

    def render_partial(name, locals=nil)
      append :render_partial, name, locals
    end

  end
end
