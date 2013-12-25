require 'spec_helper'

describe KnowledgeSpaceParser do
  describe 'parse' do
    let(:path){ "spec/parser/xml/knowledge-net-example-0.xml" }
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
      puts '知识空间：'
      knowledge_space_nodes.each { |node|
        puts "[#{node.knowledge_nodes.map(&:id).join(',')}]"
        node.children.each { |child|
          puts "-> [#{child.knowledge_nodes.map(&:id).join(',')}]"
        }
      }
      puts ''
      # puts knowledge_space_net.to_xml
    }

    describe '节点关系检查' do
      before {
        @k1 = knowledge_net.find_node_by_id('k1')
        @k2 = knowledge_net.find_node_by_id('k2')
        @k3 = knowledge_net.find_node_by_id('k3')
      }

      it('k1') {
        children = knowledge_space_net.get_space_node([@k1]).children
        children.length.should == 1
        children[0].knowledge_nodes.should =~ [@k1, @k2]
      }

      it('k2') {
        children = knowledge_space_net.get_space_node([@k2]).children
        children.length.should == 1
        children[0].knowledge_nodes.should =~ [@k1, @k2]
      }

      it('k1,k2') {
        children = knowledge_space_net.get_space_node([@k2, @k1]).children
        children.length.should == 1
        children[0].knowledge_nodes.should =~ [@k1, @k3, @k2]
      }
    end
  end

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
      puts '知识空间：'
      knowledge_space_nodes.each { |node|
        puts "[#{node.knowledge_nodes.map(&:id).join(',')}]"
        node.children.each { |child|
          puts "-> [#{child.knowledge_nodes.map(&:id).join(',')}]"
        }
      }
      puts ''
      # puts knowledge_space_net.to_xml
    }

    describe '节点关系检查' do
      before {
        @k1 = knowledge_net.find_node_by_id('k1')
        @k2 = knowledge_net.find_node_by_id('k2')
        @k3 = knowledge_net.find_node_by_id('k3')
        @k4 = knowledge_net.find_node_by_id('k4')
        @k5 = knowledge_net.find_node_by_id('k5')
      }

      it('k1') {
        children = knowledge_space_net.get_space_node([@k1]).children
        children.length.should == 2
        children.include?(knowledge_space_net.get_space_node([@k1, @k2])).should == true
        children.include?(knowledge_space_net.get_space_node([@k1, @k3])).should == true
      }

      it('k3') {
        children = knowledge_space_net.get_space_node([@k3]).children
        children.length.should == 1
        children.include?(knowledge_space_net.get_space_node([@k3, @k1])).should == true
      }

      it('k1,k2,k3') {
        children = knowledge_space_net.get_space_node([@k2, @k1, @k3]).children
        children.length.should == 2
        children.include?(knowledge_space_net.get_space_node([@k3, @k1, @k2, @k5])).should == true
        children.include?(knowledge_space_net.get_space_node([@k3, @k1, @k4, @k2])).should == true
      }
    end
  end

  describe 'parse-lifei-example' do
    let(:path){ "config/knowledge_nets/test/2.xml" }
    let(:knowledge_net){ KnowledgeNet.load_xml_file(path) }
    let(:knowledge_space_net) {
      KnowledgeSpaceParser.new(knowledge_net).parse
    }
    let(:knowledge_space_nodes) {
      knowledge_space_net.knowledge_space_nodes
    }

    it {
      puts '知识空间：'
      knowledge_space_nodes.each { |node|
        puts "[#{node.knowledge_nodes.map(&:id).join(',')}]"
        node.children.each { |child|
          puts "-> [#{child.knowledge_nodes.map(&:id).join(',')}]"
        }
      }
      puts ''
      puts knowledge_space_net.to_xml
    }
  end
end