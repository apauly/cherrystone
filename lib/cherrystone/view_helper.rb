ActiveSupport.on_load :cherrystone_core do

  #
  # Create root DSL methods
  #
  Cherrystone::ViewHelper.cherrystone_helper(
    collection_table: Cherrystone::Node::CollectionTable,
    detail_view: Cherrystone::Node::DetailView,
    custom_form: Cherrystone::Node::CustomForm
  )

end
