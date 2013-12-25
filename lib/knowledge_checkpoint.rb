class KnowledgeCheckpoint < BaseKnowledgeSet
  attr_accessor :checkpoint_id, :deep, :learned_sets

  def initialize(attrs)
    @checkpoint_id = attrs.delete :checkpoint_id
    @deep          = attrs.delete :deep
    @learned_sets  = attrs.delete :learned_sets

    super
  end

end