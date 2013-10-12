class KnowledgeSpaceParser
  class << self
    def load(knowledge_net, space_net_xml_path)
      doc = Nokogiri::XML(File.open(space_net_xml_path))
      KnowledgeSpaceNet.new(knowledge_net, doc)
    end
  end

  def initialize(knowledge_net)
    @knowledge_net = knowledge_net
  end

  def new_id
    re = @next_id ? @next_id : 1
    @next_id = re + 1

    return "ks#{re}"
  end

  def parse
    @knowledge_space_net = KnowledgeSpaceNet.new(@knowledge_net)
    
    # 第一步，先取得知识网络中所有的初始节点
    # 分别构建第一批知识空间节点
    parse_root_nodes

    # 第二步，以当前知识空间节点为基础，
    # 逐一获取每个知识空间节点的外联 outer_nodes
    # 将每个 outer_node 添加到当前空间节点，形成一个新的空间节点
    # 如果这个新的空间节点还不存在于空间中，则添加进来。直到无可添加为止

    @knowledge_space_net.knowledge_space_nodes.each { |space_node|
      _r_parse_space_node(space_node)
    }

    return @knowledge_space_net
  end

  def parse_root_nodes
    @knowledge_net.root_nodes.each { |node|
      space_node = KnowledgeSpaceNode.new(new_id, [node])
      @knowledge_space_net.add_node(space_node)
    }
  end

  def _r_parse_space_node(space_node)
    new_space_nodes = []

    # 第一步，逐个遍历 outer_nodes 看是否有可以添加的状态
    space_node.outer_nodes.each { |outer_node|
      new_state_nodes = (space_node.knowledge_nodes + [outer_node])

      # 如果新状态还未加入，则加入
      if @knowledge_space_net.get_space_node(new_state_nodes).nil?
        new_space_node = KnowledgeSpaceNode.new(new_id, new_state_nodes) # TODO 构建时可能需要排序以便后续使用
        @knowledge_space_net.add_relation(space_node, new_space_node)
        new_space_nodes << new_space_node
      end
    }

    # 第二步，如果有新状态加入，进一步处理这些新状态
    new_space_nodes.each { |_space_node|
      _r_parse_space_node(_space_node)
    }
  end
end
