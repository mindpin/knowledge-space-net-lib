module KnowledgeSpaceNetLib
  class KnowledgeNode
    attr_accessor :node_id, :name, :desc, :required, :set,
                  :parents, :children

    def initialize(attrs)
      @node_id  = attrs.delete :node_id
      @set      = attrs.delete :set
      @name     = attrs.delete :name
      @required = attrs.delete :required
      @desc     = attrs.delete :desc

      @parents = []
      @children = []

      @set.add_node(self)
    end

    def is_root?
      @parents.count == 0
    end

    def add_child(child)
      @children << child
      child.parents << self
    end

  end
end