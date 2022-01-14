# frozen_string_literal: true

module Cherrystone
  class Node::GridNode < Node::Base

    def attributes(options=nil, &block)
      append node_class(:attributes, Node::AttributesNode).new(:attributes, nil, options), &block
    end

  end
end
