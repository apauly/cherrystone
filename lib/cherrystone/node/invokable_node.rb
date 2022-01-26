# frozen_string_literal: true

module Cherrystone
  class Node::InvokableNode < Node::Base
    attr_reader :block

    def run(&block)
      @block = block
    end

    def callable?
      @block != nil
    end

    def invoke_block(record)
      return unless callable?

      instance = instance_for_block
      result = Docile.dsl_eval_with_block_return(instance, record, &@block)
      if instance == self
        result
      else
        instance.parent ||= self
        instance
      end
    end
    alias_method :call, :invoke_block

    def instance_for_block
      self
    end

  end
end
