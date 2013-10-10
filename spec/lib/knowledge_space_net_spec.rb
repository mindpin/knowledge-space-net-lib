require 'spec_helper'

describe KnowledgeSpaceNet do

  describe 'load' do
    before do
      knowledge_net_xml = "config/knowledge_nets/test_2.xml"
      knowledge_space_net_xml = "config/knowledge_space_nets/test_2.xml"
      @knowledge_net = KnowledgeNet.load_xml_file(knowledge_net_xml)
      @knowledge_space_net = KnowledgeSpaceParser.load(knowledge_net, knowledge_space_net_xml)
    end

    it{
      sapce_nodes = @knowledge_space_net.root_nodes
    }

  end

end