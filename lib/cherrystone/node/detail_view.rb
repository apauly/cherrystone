# frozen_string_literal: true

module Cherrystone
  class Node::DetailView < Cherrystone::Node::Page

    settings :has_tabs

    def action(i18n_key, url=nil, options=nil, &block)
      payload = { title: i18n_key, url: url }
      node = node_class(:action, InvokableNode).new(:action, payload, options)
      append node, &block
    end

    def grid(options=nil, &block)
      append node_class(:grid, Node::GridNode).new(:grid, nil, options), &block
    end

    def collection_table(*args, &block)
      append node_class(:collection_table, Node::CollectionTable).new(:collection_table, *args), &block
    end

  end
end
