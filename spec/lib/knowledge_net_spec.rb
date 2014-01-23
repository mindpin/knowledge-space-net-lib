require 'spec_helper'

describe KnowledgeSpaceNetLib::KnowledgeNet do
  before{
    @net = KnowledgeSpaceNetLib::KnowledgeNet.find("test1")
  }

  it{
    @net.relations.count.should == 9
    @net.relations.first.class.should == KnowledgeSpaceNetLib::BaseKnowledgeSetRelation
  }

  it{
    @net.id.should == "test1"
    @net.name.should == "测试1"
    @net.sets.count.should == 8
    @net.nodes.count.should == 35
    @net.checkpoints.count.should == 1
    @net.root_sets.count.should == 1

    @net.nodes.first.class.should == KnowledgeSpaceNetLib::KnowledgeNode
    @net.sets.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
    @net.checkpoints.first.class.should == KnowledgeSpaceNetLib::KnowledgeCheckpoint
    @net.root_sets.first.class.should == KnowledgeSpaceNetLib::KnowledgeSet
  }

  it{
    set = @net.find_set_by_id("set-8")
    set.relations.count.should == 4
    set.relations.first.class.should == KnowledgeSpaceNetLib::BaseKnowledgeNodeRelation
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
    node_24 = @net.find_node_by_id("node-24")
    node_24.id.should == "node-24"
    node_24.ancestor_ids.should == [
      "node-15", "node-16", "node-17", "node-18", 
      "node-1", "node-2", "node-4", "node-5", 
      "node-6", "node-7", "node-8", "node-9", 
      "node-31", "node-32", "node-33", "node-34", 
      "node-10", "node-11", "node-13", "node-14", "node-23"]
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