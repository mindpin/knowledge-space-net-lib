knowledge-space-net-lib
=======================


## API

获取知识网
```
  # 获取所有知识网
  nets = KnowledgeNet.all
  # 获取 javascript 的知识网
  net = KnowledgeNet.get_by_name("javascript")
```

KnowledgeNet 对象上的方法和属性
```
  net = KnowledgeNet.get_by_name("javascript")

  # 获取 net 的名字
  net.name
  # 获取 net 内的所有知识单元
  net.sets
  # 获取 net 内的所有知识检查点
  net.checkpoints
  # 获取 net 内的根知识单元
  net.root_sets()

  # 根据 set_id 找到知识单元
  net.find_set_by_id("set-1")
  # 根据 set_id 找到知识检查点
  net.find_checkpoint_by_id("checkpoint-1")
  # 根据 set_id 找到知识节点
  net.find_node_by_id("node-1")
```

KnowledgeSet 对象上的方法和属性
```
  set = net.find_set_by_id("set-1")

  # 四个基础属性
  set.set_id
  set.name
  set.icon
  set.deep

  # set 内的所有知识节点
  set.nodes
  # set 的所有根知识节点
  set.root_nodes()
```

KnowledgeCheckpoint 对象上的方法和属性
```
  checkpoint = net.find_checkpoint_by_id("checkpoint-1")
  # 两个基础属性
  checkpoint.checkpoint_id
  checkpoint.deep
  # checkpoint 包含的知识单元
  checkpoint.learned_sets
```

KnowledgeSet 和 KnowledgeCheckpoint 对象同有的方法和属性
```
  # 前置知识单元或知识检查点
  set_or_checkpoint.parents
  # 后续知识单元或知识检查点
  set_or_checkpoint.children
```


KnowledgeNode 对象上的方法和属性
```
  node = net.find_node_by_id("node-1")
  # 四个基础属性
  node.node_id
  node.name
  node.desc
  node.required
  # node 所属的知识单元
  node.set
  # node 的所有前置知识节点
  node.parents
  # node 的所有后续知识节点
  node.children
  # node 是否是所属知识单元下的根知识节点
  node.is_root?()
```