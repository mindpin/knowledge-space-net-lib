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

    def ancestor
      arr = []
      arr += set.ancestor.map{|a|a.required_nodes}.flatten
      arr += _ancestor_in_self_set
      arr.uniq
    end

    def ancestor_ids
      ancestor.map{|a|a.id}
    end

    def _ancestor_in_self_set
      result_arr = []
      _ancestor_in_self_set_each_parent(self, result_arr)
      result_arr.uniq
    end

    def _ancestor_in_self_set_each_parent(node, result_arr)
      node.parents.each do |n|
        result_arr << n
        _ancestor_in_self_set_each_parent(n, result_arr)
      end
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