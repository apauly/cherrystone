module Cherrystone
  class DslCaller

    def self.enhance_exceptions
      Cherrystone::Node.prepend NodeWithCaller
      Cherrystone::Renderer.prepend RendererWithExceptionHandling
    end

    module NodeWithCaller
      def self.prepended(base)
        base.attr_accessor :dsl_caller
      end

      def append(*args)
        super.tap {|child_node|
          child_node.dsl_caller = caller.detect {|path|
            !path.include?(Cherrystone::Engine.root.to_s) && !path.include?('docile')
          }
        }
      end
    end

    module RendererWithExceptionHandling
      def render(view_context, name_or_node, locals=nil, &block)
        RendererWithExceptionHandling.collect_dsl_caller(name_or_node) do
          super
        end
      end

      def self.collect_dsl_caller(node, &block)
        yield
      rescue ActionView::Template::Error => e
        if node.is_a?(Cherrystone::Node)
          e.sub_template_of("[CHERRYSTONE NODE] #{node.name} called from #{node.dsl_caller}")
        end

        raise e
      end
    end
  end
end
