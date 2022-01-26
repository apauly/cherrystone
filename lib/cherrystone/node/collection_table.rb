# frozen_string_literal: true

module Cherrystone
  class Node::CollectionTable < Cherrystone::Node::Page

    def collection=(collection)
      @payload = collection

      # set the resource_class as an option so child nodes have access to it via +find_option+
      # TODO: Still needed?
      self.options[:resource_class] = collection.klass
    end

    def payload
      @payload || options[:controller].collection
    end
    alias_method :collection, :payload

    # TODO: Still needed?
    def resource_class
      self.options[:resource_class]
    end

    def collection_action(i18n_key, url, options=nil)
      payload = { title: i18n_key, url: url }
      append(:collection_action, payload, options)
    end

    def batch_action(name, options=nil)
      payload = { name: name }
      append(:batch_action, payload, options)
    end

    def row_action(&block)
      node = node_class(:row_action, InvokableNode).new(:row_action)
      append node, &block
    end

    def related_links(&block)
      node = node_class(:related_links, Node::RelatedLinks).new(:related_links)
      append node, &block
    end

    def filter(name, type, options={})
      payload = { name: name, type: type }
      append(:filter, payload, options)
    end

    def filter_preset(name, options={})
      payload = { name: name }
      append(:filter_preset, payload, options)
    end

    def column(name, options=nil, &block)
      node = node_class(:column, InvokableNode).new(:column, name, options)
      append node, &block
    end

  end
end
