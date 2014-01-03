module KnowledgeSpaceNetLib
  class KnowledgeSet < BaseKnowledgeSet
    attr_accessor :net, :id, :name, :icon, :deep

    def initialize(attrs)
      @net  = attrs.delete :net
      @id = attrs.delete :id
      @name = attrs.delete :name
      @icon = attrs.delete :icon
      @deep = attrs.delete :deep
      @node_ids = []
      super
    end

    def add_node(node)
      @node_ids << node.id
    end

    def nodes
      @node_ids.map do |id|
        @net.find_node_by_id(id)
      end
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