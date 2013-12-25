class KnowledgeNodeRelation
  attr_accessor :parent, :child

  def initialize(parent, child)
    @parent = parent
    @child = child
  end
end