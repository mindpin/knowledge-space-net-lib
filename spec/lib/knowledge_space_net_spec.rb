require 'spec_helper'

describe KnowledgeSpaceNet do

  describe 'load' do
    before do
      knowledge_net_xml = "config/knowledge_nets/test_2.xml"
      knowledge_space_net_xml = "config/knowledge_space_nets/test_2.xml"
      @knowledge_net = KnowledgeNet.load_xml_file(knowledge_net_xml)
      @knowledge_space_net = KnowledgeSpaceParser.load(@knowledge_net, knowledge_space_net_xml)
      @root_sapce_nodes = @knowledge_space_net.root_nodes
    end

    it{
      @root_sapce_nodes.length.should == 1
    }

    it{
      @root_sapce_nodes[0].knowledge_nodes.should == []
      @root_sapce_nodes[0].parents.should == []
    }

    it{
      @root_sapce_nodes[0].children.length.should == 3
      @root_sapce_nodes[0].children.map(&:id).should =~ ["ks2","ks3","ks4"]
      ks2 = @root_sapce_nodes[0].children.select{|node|
        node.id == "ks2"
      }[0]
      ks2.knowledge_nodes.map(&:id).should =~ ["k1"]
      ks2.parents.map(&:id).should =~ ["ks1"]
      ks2.children.map(&:id).should =~ ["ks5","ks7"]
    }

  end

end