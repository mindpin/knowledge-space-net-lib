require 'nokogiri'

class KnowledgeNet
  attr_accessor :knowledge_nodes

  def initialize(doc)
    hash = {}
    doc.css("nodes node").each do |node|
      id = node.attr("id")
      hash[id] = KnowledgeNode.new(
                                    :id => id,
                                    :name => node.css("name").first.text,
                                    :desc => node.css("desc").first.text
                                  )
    end

    doc.css("relations relation").map do |relation|
      parent_id =  relation.css("parent").first.attr("node_id")
      child_id  =  relation.css("child").first.attr("node_id")
      hash[parent_id].children << child_id if hash[parent_id] != nil
      hash[child_id].parents << parent_id if hash[child_id] != nil 
    end
    self.knowledge_nodes = hash
  end

  def self.load_xml_file(file_path)
    doc = Nokogiri::XML(File.open(file_path))
    KnowledgeNet.new(doc)
  end

  def root_nodes
    kns = []
    self.knowledge_nodes.each do |k,v|
      kns << v if v.is_no_parents
    end
    kns
  end

  def find_node_by_id(node_id)
    self.knowledge_nodes[node_id] || nil
  end
end