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
    # 分别计算每个知识空间节点的外联
    parse_root_nodes


    return @knowledge_space_net
  end

  def parse_root_nodes
    @knowledge_net.root_nodes.each { |node|
      space_node = KnowledgeSpaceNode.new(new_id, [node])
      @knowledge_space_net.add_node(space_node)
    }
  end
end
