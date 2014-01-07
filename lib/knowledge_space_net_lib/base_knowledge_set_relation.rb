module KnowledgeSpaceNetLib
  class BaseKnowledgeSetRelation
    attr_reader :child, :parent
    def initialize(attrs)
      @child = attrs.delete :child
      @parent = attrs.delete :parent
    end
  end
end