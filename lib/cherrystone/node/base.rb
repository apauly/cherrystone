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

    def subtitle(value)
      append :subtitle, value
    end

    def paragraph(value)
      append :paragraph, value
    end

    def render_partial(name, locals=nil)
      append :render_partial, name, locals
    end

    def inspect
      options_for_inspect = @options.except(:controller)
      options_for_inspect[:controller] = "<##{options[:controller].class}>" if options[:controller]
      "<##{self.class.to_s} @name=#{name.inspect} @payload=#{@payload.inspect} @options=#{options_for_inspect.inspect}>"
    end

  end
end
