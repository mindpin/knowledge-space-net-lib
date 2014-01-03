module KnowledgeSpaceNetLib
  class KnowledgeCheckpoint < BaseKnowledgeSet
    attr_accessor :id, :deep

    def initialize(attrs)
      @net           = attrs.delete :net
      @id            = attrs.delete :id
      @deep          = attrs.delete :deep
      @learned_set_ids  = attrs.delete :learned_set_ids

      super
    end

    def learned_sets
      @learned_set_ids.map do |id|
        @net.find_set_by_id(id)
      end
    end

  end
end