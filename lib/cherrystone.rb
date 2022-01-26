# frozen_string_literal: true

require 'cherrystone_core'

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup

require 'cherrystone/engine'
require 'cherrystone/node/base'
require 'cherrystone/node/attributes_node'
require 'cherrystone/node/collection_table'
require 'cherrystone/node/detail_view'
require 'cherrystone/node/grid_node'
require 'cherrystone/node/invokable_node'
require 'cherrystone/node/related_links'
