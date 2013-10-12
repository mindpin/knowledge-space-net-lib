class KnowledgeSpaceNode
  attr_reader :id, :knowledge_nodes, :parents, :children
  attr_accessor :knowledge_net
  def initialize(id, knowledge_nodes)
    @id = id
    @knowledge_nodes = knowledge_nodes
    @parents = []
    @children = []
  end

  def add_relation(relation)
    add_child(relation.child) if relation.parent == self
    add_parent(relation.parent) if relation.child == self
  end

  def add_parent(parent)
    return if @parents.include?(parent)
    @parents.push(parent)
  end

  def add_child(child)
    return if @children.include?(child)
    @children.push(child)
  end

  def outer_nodes
    @outer_nodes ||= (
      @knowledge_nodes.map do |knowledge_node|
        knowledge_node.children
      end.flatten.select do |knowledge_node|
        !@knowledge_nodes.include?(knowledge_node) &&
          knowledge_node.parents - @knowledge_nodes == []
      end + (@knowledge_net.root_nodes - @knowledge_nodes)
    ).uniq
  end

end