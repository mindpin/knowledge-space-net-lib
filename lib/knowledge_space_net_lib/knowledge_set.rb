module KnowledgeSpaceNetLib
  class KnowledgeSet < BaseKnowledgeSet
    attr_accessor :set_id, :name, :icon, :deep, :nodes

    def initialize(attrs)
      @set_id = attrs.delete :set_id
      @name = attrs.delete :name
      @icon = attrs.delete :icon
      @deep = attrs.delete :deep
      @nodes = []
      super
    end

    def add_node(node)
      @nodes << node
    end

    def root_nodes
      kns = []
      @nodes.each do |v|
        kns << v if v.is_root?
      end
      kns
    end
  end
end