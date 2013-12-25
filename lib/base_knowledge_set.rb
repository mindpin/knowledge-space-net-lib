class BaseKnowledgeSet
  attr_accessor :parents, :children, :relations
  def initialize(attrs)
    @relations = []
    @children  = []
    @parents   = []
  end

  def add_relation(relation)
    @relations << relation

    if relation.parent == self
      @children << relation.child
    elsif relation.child == self
      @parents  << relation.parent
    end
  end

  def is_root?
    @parents.count == 0
  end
end