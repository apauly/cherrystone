# frozen_string_literal: true

module Cherrystone
  class Node::TextNode < Node::Base

    def run(&block)
      append :text, Docile.dsl_eval_with_block_return(self, &block)
    end

  end
end
