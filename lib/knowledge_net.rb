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
      parent = relation.css("parent").first.attr("node_id")
      child = relation.css("child").first.attr("node_id")
      kns.map do |knowledge_node|
        knowledge_node.children = child if knowledge_node.id == parent
        knowledge_node.parents = parent if knowledge_node.id == child
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
end

# knowledge_net = KnowledgeNet.load_xml_file("config/knowledge_nets/1.xml")
# knowledge_net.root_nodes