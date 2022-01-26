module Cherrystone
  class DebugRenderer

    def self.render(view_context, node, _locals=nil)
      debug_node(node).ai(html: true) if view_context.params[:debug]
    end

    def self.debug_node(node)
      if node.is_a?(Array)
        return node.map {|child|
          debug_node(child)
        }
      end

      {
        name: node.name,
        payload: node.payload.inspect,
        options: node.options.inspect,
        children: node.children.map {|child_node|
          debug_node(child_node)
        },
        block: node.try(:block)
      }
    end

  end
end
