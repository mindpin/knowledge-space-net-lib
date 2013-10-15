require 'knowledge_net'
require 'knowledge_node'
require 'knowledge_space_net'
require 'knowledge_space_node'
require 'knowledge_space_parser'
require 'knowledge_space_relation'
require 'fileutils'

module KnowledgeSpaceNetLib
  BASE_PATH = File.expand_path("../../",__FILE__)
end

KnowledgeNet::JAVASCRIPT_CORE = KnowledgeNet.load_xml_file("config/knowledge_nets/javascript_core.xml")