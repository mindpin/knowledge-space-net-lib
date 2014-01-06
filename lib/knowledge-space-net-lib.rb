require 'fileutils'

require 'knowledge_space_net_lib/knowledge_net'
require 'knowledge_space_net_lib/knowledge_node'
require 'knowledge_space_net_lib/base_knowledge_set'
require 'knowledge_space_net_lib/knowledge_set'
require 'knowledge_space_net_lib/knowledge_checkpoint'
require 'knowledge_space_net_lib/knowledge_node'

module KnowledgeSpaceNetLib
  BASE_PATH = File.expand_path("../../",__FILE__)
  DATA = {
    "javascript" => KnowledgeNet.load_xml_file("config/knowledge_nets/javascript.xml", "javascript"),
    "test1" => KnowledgeNet.load_xml_file("config/knowledge_nets/test1.xml","测试1")
  }
end