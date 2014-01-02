require 'spec_helper'

describe KnowledgeNet do
  before{
    @net = KnowledgeNet.get_by_name("test1")
  }

  it{
    @net.name.should == "test1"
    @net.sets.count.should == 8
    @net.checkpoints.count.should == 1
    @net.root_sets.count.should == 1
  }

  it{
    set_8 = @net.find_set_by_id("set-8")
    set_8.set_id.should == "set-8"
    set_8.name.should == "基础: 值"
    set_8.icon.should == "set-8"
    set_8.deep.should == 1
    set_8.nodes.count.should == 5
    set_8.root_nodes.count.should == 1
    set_8.parents.count.should == 0
    set_8.children.count.should == 1
    set_8.relations.count.should == 1
  }

  it{
    @net.checkpoints.count.should == 1
    checkpoint = @net.checkpoints.first
    checkpoint.checkpoint_id.should == "checkpoint-1"
    checkpoint.learned_sets.count.should == 4
    checkpoint.parents.count.should == 2
    checkpoint.children.count.should == 1
    checkpoint.relations.count.should == 3
  }

  it{
    node_31 = @net.find_node_by_id("node-31")
    node_31.node_id.should == "node-31"
    node_31.name.should == "字符串"
    node_31.required.should == true
    node_31.desc.should == "怎样在程序里表示一个字符串"
    node_31.set.set_id.should == "set-8"
    node_31.children.count.should == 2
    node_31.parents.count.should == 0
    node_31.relations.count.should == 2
    node_31.relations.first.parent == node_31
  }

  it{
    net = KnowledgeNet.get_by_name("javascript")
    net.name.should == "javascript"
    net.class.should == KnowledgeNet
    net.find_set_by_id("set-8").set_id.should == "set-8"
    net.find_checkpoint_by_id("checkpoint-1").checkpoint_id.should == "checkpoint-1"
    net.find_node_by_id("node-31").node_id.should == "node-31"
  }

end