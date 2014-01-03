module KnowledgeSpaceNetLib
  class BaseKnowledgeSet
    attr_accessor :parent_ids, :child_ids
    def initialize(attrs)
      @parent_ids  = []
      @child_ids   = []
    end

    def add_child(child)
      @child_ids << child.id
      child.parent_ids << self.id
    end

    def is_root?
      @parent_ids.count == 0
    end

    def parents
      @parent_ids.map do |id|
        @net.find_set_or_checkpoint_by_id(id)
      end
    end

    def children
      @child_ids.map do |id|
        @net.find_set_or_checkpoint_by_id(id)
      end
    end

  end
end