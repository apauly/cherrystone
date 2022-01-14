# frozen_string_literal: true

module Cherrystone
  class Node::RelatedLinks < Node::InvokableNode

    class InvokedRelatedLinks < Node::Base
      def link(title, url=nil, options=nil)
        payload = { title: title, url: url }
        append :link, payload, options
      end
    end

    def instance_for_block
      node_class(:related_links, InvokedRelatedLinks).new(:related_links)
    end

  end
end
