ActiveSupport.on_load :cherrystone_core do

  Cherrystone::ViewHelper.cherrystone_helper(
    collection_table: Cherrystone::Node::CollectionTable,
    detail_view: Cherrystone::Node::DetailView,
    custom_form: Cherrystone::Node::CustomForm
  )

end
