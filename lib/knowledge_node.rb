class KnowledgeNode
  attr_accessor :id, :name, :desc, :parents, :children

  def initialize(option={})
    self.id = option[:id]
    self.name = option[:name]
    self.desc = option[:desc]
  end

  def is_no_parents
    self.parents == nil
  end
end