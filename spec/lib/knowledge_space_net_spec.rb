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

    describe 'outer_nodes' do
      it{
        ks1 = @knowledge_space_net.get_space_node([])
        ks1.outer_nodes.map(&:id).should =~ ["k1","k2","k3"]
      }

      it{
        k1 = @knowledge_net.find_node_by_id('k1')
        ks2 = @knowledge_space_net.get_space_node([k1])
        ks2.outer_nodes.map(&:id).should =~ ['k2','k3']
      }

      it{
        k1 = @knowledge_net.find_node_by_id('k1')
        k2 = @knowledge_net.find_node_by_id('k2')
        ks5 = @knowledge_space_net.get_space_node([k1,k2])
        ks5.outer_nodes.map(&:id).should =~ ['k3']
      }

      it{
        k1 = @knowledge_net.find_node_by_id('k1')
        k2 = @knowledge_net.find_node_by_id('k2')
        k3 = @knowledge_net.find_node_by_id('k3')
        ks8 = @knowledge_space_net.get_space_node([k1,k2,k3])
        ks8.outer_nodes.map(&:id).should =~ ['k4']
      }

      it{
        k1 = @knowledge_net.find_node_by_id('k1')
        k2 = @knowledge_net.find_node_by_id('k2')
        k3 = @knowledge_net.find_node_by_id('k3')
        k4 = @knowledge_net.find_node_by_id('k4')
        ks9 = @knowledge_space_net.get_space_node([k1,k2,k3,k4])
        ks9.outer_nodes.map(&:id).should =~ ['k5','k6']
      }

      it{
        k1 = @knowledge_net.find_node_by_id('k1')
        k2 = @knowledge_net.find_node_by_id('k2')
        k3 = @knowledge_net.find_node_by_id('k3')
        k4 = @knowledge_net.find_node_by_id('k4')
        k5 = @knowledge_net.find_node_by_id('k5')
        ks10 = @knowledge_space_net.get_space_node([k1,k2,k3,k4,k5])
        ks10.outer_nodes.map(&:id).should =~ ['k6']
      }
    end
  end

  describe 'parse' do
    before do
      knowledge_net_xml = "config/knowledge_nets/test_2.xml"
      @knowledge_net = KnowledgeNet.load_xml_file(knowledge_net_xml)
      @knowledge_space_net = KnowledgeSpaceNet.new(@knowledge_net)
    end

    it{
      @knowledge_space_net.knowledge_space_nodes.should == []
    }

    it{
      k2 = @knowledge_net.find_node_by_id('k2')
      @knowledge_space_net.knowledge_space_nodes.should == []
      @knowledge_space_net.get_space_node([k2]).should == nil
      space_node = KnowledgeSpaceNode.new('ks1', [k2])
      @knowledge_space_net.add_node(space_node)
      @knowledge_space_net.knowledge_space_nodes.should == [space_node]
      @knowledge_space_net.get_space_node([k2]).should == space_node
    }
  end
end