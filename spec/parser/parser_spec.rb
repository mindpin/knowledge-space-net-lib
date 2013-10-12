require 'spec_helper'

describe KnowledgeSpaceParser do
  describe 'parse' do
    let(:path){ "spec/parser/xml/knowledge-net-example-1.xml" }
    let(:knowledge_net){ KnowledgeNet.load_xml_file(path) }
    let(:knowledge_space_net) {
      KnowledgeSpaceParser.parse(knowledge_net)
    }
    let(:knowledge_space_nodes) {
      knowledge_space_net.knowledge_space_nodes
    }

    it {
      knowledge_space_net.class.should == KnowledgeSpaceNet
    }

    it {
      knowledge_space_nodes.class.should == Array
    }

    it {
      # knowledge_space_nodes.length.should > 0
    }
  end
end