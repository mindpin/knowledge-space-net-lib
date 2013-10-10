class KnowledgeSpaceNet
  attr_reader :root_nodes
  def initialize(knowledge_net, doc)
    @knowledge_net = knowledge_net
    @doc = doc
    _build_knowledge_space_nodes()
    _build_node_relaction()
    _build_root_nodes()
  end

  private
  def _build_node_relaction
    @doc.css("relations relation").each do |relation|
      parent_id = relation.at_css("parent").attr("node_id")
      child_id = relation.at_css("child").attr("node_id")
      parent = @knowledge_space_nodes_hash[parent_id]
      child = @knowledge_space_nodes_hash[child_id]
      KnowledgeSapceNode.add_relaction(parent, child)
    end
  end

  def _build_root_nodes
    @root_nodes = @knowledge_space_nodes.select do |node|
      node.parents.length == 0
    end
  end

  def _build_knowledge_space_nodes
    @knowledge_space_nodes_hash = {}
    @knowledge_space_nodes = []
    @doc.css("KnowledgeSapceNet nodes node").each do |node|
      space_node_id = node.attr("id")

      knowledge_nodes = []
      node.css('knowledge_node_ids id').each do |id_node|
        node_id = id_node.text()
        knowledge_nodes << @knowledge_net.find_node_by_id(node_id)
      end

      node = KnowledgeSapceNode.new(space_node_id, knowledge_nodes)
      @knowledge_space_nodes_hash[node.id] = node
      @knowledge_space_nodes << node
    end
  end
end