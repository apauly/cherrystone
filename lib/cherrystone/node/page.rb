# frozen_string_literal: true

module Cherrystone
  class Node::Page < Node::Base

    def subtitle(value)
      append :subtitle, value
    end

    def paragraph(value)
      append :paragraph, value
    end

    def tab_navigation
      append :tab_navigation
    end

  end
end
