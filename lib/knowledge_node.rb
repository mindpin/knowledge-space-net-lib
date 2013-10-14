class KnowledgeNode
  attr_accessor :id, :name, :desc, :parents, :children

  def initialize(option={})
    self.id = option[:id]
    self.name = option[:name]
    self.desc = option[:desc]
    self.parents = []
    self.children = []
  end

  def has_no_parents?
    self.parents.count == 0
  end
end