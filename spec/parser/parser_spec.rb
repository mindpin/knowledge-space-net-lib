require 'spec_helper'

describe KnowledgeSpaceParser do
  describe 'parse' do
    let(:path){ "spec/parser/xml/knowledge-net-example-1.xml" }
    let(:knowledge_net){ KnowledgeNet.load_xml_file(path) }
    let(:knowledge_space_net) {
      KnowledgeSpaceParser.new(knowledge_net).parse
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
      knowledge_space_nodes.length.should > 0
    }

    it('知识网络根节点应当有对应的知识空间节点') {
      knowledge_net.root_nodes.each { |node|
        knowledge_space_net.get_space_node([node]).should_not nil
      }
    }

    it {
      knowledge_space_nodes.each { |node|
        p 111
        p node.knowledge_nodes.map(&:id)
        p node.outer_nodes.map(&:id)
      }
    }
  end
end