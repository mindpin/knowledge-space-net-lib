require 'nokogiri'

class KnowledgeNet
  attr_accessor :knowledge_nodes

  def initialize(doc)
    kns = []
    doc.css("nodes node").each do |node|
      kns << KnowledgeNode.new(
          :id => node.attr("id"),
          :name => node.css("name").first.text,
          :desc => node.css("desc").first.text
        )
    end

    doc.css("relations relation").map do |relation|
      parent_arr =  get_css_arr(relation.css("parent"))
      child_arr  =  get_css_arr(relation.css("child"))
      kns.map do |knowledge_node|
        knowledge_node.children = knowledge_node.children + child_arr if parent_arr.include?(knowledge_node.id)
        knowledge_node.parents = knowledge_node.parents + parent_arr  if child_arr.include?(knowledge_node.id)
      end
    end
    self.knowledge_nodes = kns
  end

  def self.load_xml_file(file_path)
    doc = Nokogiri::XML(File.open(file_path))
    KnowledgeNet.new(doc)
  end

  def root_nodes
    kns = []
    self.knowledge_nodes.each do |node|
      kns << node if node.is_no_parents
    end
    kns
  end

  def find_node_by_id(node_id)
    node = self.knowledge_nodes.each do |node|
      return node if node.id == node_id
    end
    node
  end

  private
    def get_css_arr(css_arr)
      arr=[]
      css_arr.each do |css|
        arr << css.attr("node_id")
      end
      arr
    end
end