require 'spec_helper'

describe KnowledgeSpaceNetLib::KnowledgeNet do
  before{
    @net = KnowledgeSpaceNetLib::KnowledgeNet.find("test1")
  }

  it{
    @net.id.should == "test1"
    @net.name.should == "测试1"
    @net.sets.count.should == 8
    @net.checkpoints.count.should == 1
    @net.root_sets.count.should == 1

    @net.sets.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
    @net.checkpoints.first.class.should == KnowledgeSpaceNetLib::KnowledgeCheckpoint
    @net.root_sets.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
  }

  it{
    set_8 = @net.find_set_by_id("set-8")

    set_8.id.should == "set-8"
    set_8.name.should == "基础: 值"
    set_8.icon.should == "set-8"
    set_8.deep.should == 1

    set_8.nodes.count.should == 5
    set_8.root_nodes.count.should == 1
    set_8.parents.count.should == 0
    set_8.children.count.should == 1

    set_8.nodes.first.class.should == KnowledgeSpaceNetLib::KnowledgeNode
    set_8.root_nodes.first.class.should == KnowledgeSpaceNetLib::KnowledgeNode
    set_8.children.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
  }

  it{
    @net.checkpoints.count.should == 1
    checkpoint = @net.checkpoints.first
    checkpoint.id.should == "checkpoint-1"
    checkpoint.learned_sets.count.should == 4
    checkpoint.parents.count.should == 2
    checkpoint.children.count.should == 1

    checkpoint.learned_sets.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
    checkpoint.parents.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
    checkpoint.children.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
  }

  it{
    node_31 = @net.find_node_by_id("node-31")
    node_31.id.should == "node-31"
    node_31.name.should == "字符串"
    node_31.required.should == true
    node_31.desc.should == "怎样在程序里表示一个字符串"
    node_31.set.id.should == "set-8"
    node_31.children.count.should == 2
    node_31.parents.count.should == 0
    node_31.children.first.parents.first == node_31
  }

  it{
    net = KnowledgeSpaceNetLib::KnowledgeNet.find("javascript")
    net.name.should == "javascript"
    net.name.should == "javascript"
    net.class.should == KnowledgeSpaceNetLib::KnowledgeNet
    net.find_set_by_id("set-8").id.should == "set-8"
    net.find_checkpoint_by_id("checkpoint-1").id.should == "checkpoint-1"
    net.find_node_by_id("node-31").id.should == "node-31"
  }

end