# frozen_string_literal: true

module Cherrystone
  class Node::AttributesNode < Node::Base

    def grid(options=nil, &block)
      append node_class(:grid, Node::GridNode).new(:grid, nil, options), &block
    end

    def field(key=nil, options=nil, &block)
      if key.is_a?(Hash)
        options = key
        key = nil
      end
      node = node_class(:field, InvokableNode).new(:field, key, options)
      append node, &block
    end

  end
end
