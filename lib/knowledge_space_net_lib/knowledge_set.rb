module KnowledgeSpaceNetLib
  class KnowledgeSet < BaseKnowledgeSet
    attr_accessor :net, :id, :name, :icon, :deep, :relations

    def initialize(attrs)
      @net  = attrs.delete :net
      @id = attrs.delete :id
      @name = attrs.delete :name
      @icon = attrs.delete :icon
      @deep = attrs.delete :deep
      @node_ids = []
      @relations = []
      super
    end

    def add_node(node)
      @node_ids << node.id
    end

    def add_relation(relation)
      @relations << relation
    end

    def nodes
      @node_ids.map do |id|
        @net.find_node_by_id(id)
      end
    end

    def ancestor
      result_arr = []
      _ancestor_each_parent(self, result_arr)
      result_arr.uniq
    end

    def _ancestor_each_parent(set, result_arr)
      set.parents.each do |s|
        result_arr << s
        _ancestor_each_parent(s, result_arr)
      end
    end

    def required_nodes
      nodes.select{|node|node.required}
    end

    def root_nodes
      kns = []
      nodes.each do |v|
        kns << v if v.is_root?
      end
      kns
    end
  end
end