class Cherrystone::Renderer

  def initialize(template_path)
    @template_path = template_path
  end

  def render(view_context, name_or_node, locals=nil, &block)
    template_name = name_or_node.respond_to?(:name) ? name_or_node.name : name_or_node

    locals ||= {}
    locals[:node] ||= name_or_node
    partial(view_context, template_name, locals, &block)
  end

  def partial(view_context, partial_path, locals=nil, &block)
    partial_paths = [
      find_template_alternatives(view_context, partial_path),
      partial_path
    ].compact

    partial_path = partial_paths.detect {|name|
      view_context.lookup_context.exists?(name, [@template_path], true)
    } || partial_paths.last

    partial = File.join(@template_path, partial_path.to_s)
    locals = prepare_locals(view_context, locals)

    view_context.safe_join [
      view_context.render(partial, locals, &block).to_s
    ]
  end

  DETAIL_VIEW_VARIANT_MAPPING = {
    'index'       => 'collection_table',
    'show'        => 'detail_view',
    'create'      => 'detail_view_form',
    'edit'        => 'detail_view_form',
    'new'         => 'detail_view_form',
    'update'      => 'detail_view_form',
    'custom_form' => 'detail_view_form'
  }.freeze

  def find_template_alternatives(view_context, template_name)
    return if template_name.to_s.include?('/') # consider nested template to be fixed

    prefix = DETAIL_VIEW_VARIANT_MAPPING[view_context.action_name]
    if view_context.root_node
      prefix ||= DETAIL_VIEW_VARIANT_MAPPING[view_context.root_node.name.to_s]
      prefix ||= view_context.root_node.name.to_s
    end
    return unless prefix.present?

    File.join(prefix, template_name.to_s)
  end

  def prepare_locals(view_context, locals=nil)
    locals ||= {}
    locals.merge(
      force_virtual_path: view_context.instance_variable_get('@virtual_path'),
      renderer: self
    )
  end

end
