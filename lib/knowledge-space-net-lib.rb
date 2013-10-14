require 'knowledge_net'
require 'knowledge_node'
require 'knowledge_space_net'
require 'knowledge_space_node'
require 'knowledge_space_parser'
require 'knowledge_space_relation'

module KnowledgeSpaceNetLib
  if defined?(Rails)
    class Railtie < Rails::Railtie
      initializer "init_base_path" do
        KnowledgeSpaceNetLib::BASE_PATH = Rails.root.to_s
      end
    end
  else
    BASE_PATH = File.expand_path("../../",__FILE__)
  end
end