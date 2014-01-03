module KnowledgeSpaceNetLib
  class KnowledgeNode
    attr_accessor :net, :id, :name, :desc, :required,
                  :parent_ids, :child_ids

    def initialize(attrs)
      @net      = attrs.delete :net
      @id       = attrs.delete :id
      @set_id   = attrs.delete :set_id
      @name     = attrs.delete :name
      @required = attrs.delete :required
      @desc     = attrs.delete :desc

      @parent_ids = []
      @child_ids = []
    end

    def is_root?
      @parent_ids.count == 0
    end

    def add_child(child)
      @child_ids << child.id
      child.parent_ids << self.id
    end

    def set
      @net.find_set_by_id(@set_id)
    end

    def parents
      @parent_ids.map do |id|
        @net.find_node_by_id(id)
      end
    end

    def children
      @child_ids.map do |id|
        @net.find_node_by_id(id)
      end
    end

  end
end