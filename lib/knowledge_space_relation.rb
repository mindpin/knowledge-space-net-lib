class KnowledgeSpaceRelation
  attr_reader :parent, :child
  def initialize(parent, child)
    @parent = parent
    @child = child
  end
end