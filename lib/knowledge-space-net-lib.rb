require 'knowledge_net'
require 'knowledge_node'
require 'base_knowledge_set'
require 'knowledge_set'
require 'knowledge_checkpoint'
require 'knowledge_node'
require 'fileutils'

module KnowledgeSpaceNetLib
  BASE_PATH = File.expand_path("../../",__FILE__)
  DATA = {
    "javascript" => KnowledgeNet.load_xml_file("config/knowledge_nets/javascript.xml"),
    "test1" => KnowledgeNet.load_xml_file("config/knowledge_nets/test1.xml")
  }
end