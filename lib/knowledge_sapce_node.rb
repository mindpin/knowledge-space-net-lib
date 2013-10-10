class KnowledgeSapceNode
  attr_reader :id, :knowledge_nodes, :parents, :children

  def initialize(id, knowledge_nodes)
    @id = id
    @knowledge_nodes = knowledge_nodes
    @parents = []
    @children = []
  end

  def add_parent(parent)
    return if @parents.include?(parent)
    @parents.push(parent)
  end

  def add_child(child)
    return if @children.include?(child)
    @children.push(child)
  end

  class << self
    def add_relaction(parent, child)
      return if !parent || !child
      parent.add_child(child)
      child.add_parent(parent)
    end
  end
end