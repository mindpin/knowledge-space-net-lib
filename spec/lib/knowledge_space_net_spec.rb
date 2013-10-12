require 'spec_helper'

describe KnowledgeSpaceNet do

  describe 'load' do
    before do
      knowledge_net_xml = "config/knowledge_nets/test_2.xml"
      knowledge_space_net_xml = "config/knowledge_space_nets/test_2.xml"
      @knowledge_net = KnowledgeNet.load_xml_file(knowledge_net_xml)
      @knowledge_space_net = KnowledgeSpaceParser.load(@knowledge_net, knowledge_space_net_xml)
      @sapce_nodes = @knowledge_space_net.knowledge_space_nodes
    end

    it{
      @sapce_nodes.length.should == 12
    }

    it{
      root_node = @knowledge_space_net.get_space_node([])
      root_node.knowledge_nodes.should == []
      root_node.parents.should == []
    }

    it{
      root_node = @knowledge_space_net.get_space_node([])
      root_node.children.length.should == 3
      root_node.children.map(&:id).should =~ ["ks2","ks3","ks4"]
      ks2 = root_node.children.select{|node|
        node.id == "ks2"
      }[0]
      ks2.knowledge_nodes.map(&:id).should =~ ["k1"]
      ks2.parents.map(&:id).should =~ ["ks1"]
      ks2.children.map(&:id).should =~ ["ks5","ks7"]
    }

    it{
      k2 = @knowledge_net.find_node_by_id('k2')
      k3 = @knowledge_net.find_node_by_id('k3')
      ks6 = @knowledge_space_net.get_space_node([k3,k2])
      ks6.id.should == "ks6"
      ks6.knowledge_nodes.map(&:id).should =~ ["k2",'k3']
      ks6.parents.map(&:id).should =~ ["ks3","ks4"]
      ks6.children.map(&:id).should =~ ["ks8"]
    }

  end
end