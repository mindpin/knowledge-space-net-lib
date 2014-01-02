class BaseKnowledgeSet
  attr_accessor :parents, :children
  def initialize(attrs)
    @children  = []
    @parents   = []
  end

  def add_child(child)
    @children << child
    child.parents << self
  end

  def is_root?
    @parents.count == 0
  end
end