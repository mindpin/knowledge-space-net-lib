class KnowledgeNode
  attr_accessor :node_id, :name, :desc, :required, :set,
                :parents, :children, :relations

  def initialize(attrs)
    @node_id  = attrs.delete :node_id
    @set      = attrs.delete :set
    @name     = attrs.delete :name
    @required = attrs.delete :required
    @desc     = attrs.delete :desc

    @parents = []
    @children = []
    @relations = []

    @set.add_node(self)
  end

  def is_root?
    @parents.count == 0
  end

  def add_relation(relation)
    @relations << relation

    if relation.parent == self
      @children << relation.child
    elsif relation.child == self
      @parents  << relation.parent
    end
  end
end