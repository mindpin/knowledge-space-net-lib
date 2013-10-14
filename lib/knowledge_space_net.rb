class KnowledgeSpaceNet
  attr_reader :root_nodes,:knowledge_space_nodes
  def initialize(knowledge_net, doc = nil)
    @knowledge_net = knowledge_net
    
    @knowledge_space_nodes_id_hash = {}
    @knowledge_space_nodes_key_hash = {}
    @knowledge_space_nodes = []
    @relations = []

    if doc
      @doc = doc
      _build_knowledge_space_nodes()
      _build_node_relation()
      _build_root_nodes()
    end
  end

  def get_space_node(knowledge_nodes)
    key = _knowledge_nodes_to_key(knowledge_nodes)
    @knowledge_space_nodes_key_hash[key]
  end

  def add_node(knowledge_space_node)
    knowledge_space_node.knowledge_net = @knowledge_net
    @knowledge_space_nodes_id_hash[knowledge_space_node.id] = knowledge_space_node
    key = _knowledge_nodes_to_key(knowledge_space_node.knowledge_nodes)
    @knowledge_space_nodes_key_hash[key] = knowledge_space_node
    @knowledge_space_nodes << knowledge_space_node
  end

  def add_relation(parent_space_node, child_space_node)
    return if !parent_space_node || !child_space_node

    relation = KnowledgeSpaceRelation.new(parent_space_node, child_space_node)
    @relations.push(relation)
    parent_space_node.add_relation(relation)
    child_space_node.add_relation(relation)
  end

  def save_to(file_path)
    if defined?(Rails)
      path = Rails.root.join(file_path)
    else
      path = File.expand_path(file_path)
    end

    File.open(path,"w") do |f|
      f << to_xml()
    end
  end

  def to_xml
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.KnowledgeSapceNet{
        xml.nodes{
          @knowledge_space_nodes.each do |node|
            xml.node(:id => node.id){
              xml.knowledge_node_ids{
                node.knowledge_nodes.each do |kn|
                  xml.id kn.id
                end
              }
            }
          end
        }
        xml.relations{
          @relations.each do |relation|
            xml.relation{
              xml.parent_(:node_id => relation.parent.id)
              xml.child_(:node_id => relation.child.id)
            }
          end
        }
      }
    end
    
    builder.to_xml
  end

  private
  def _knowledge_nodes_to_key(knowledge_nodes)
    ids = knowledge_nodes.uniq.map(&:id).sort
    ids.hash
  end

  def _build_node_relation
    @doc.css("relations relation").each do |relation|
      parent_id = relation.at_css("parent").attr("node_id")
      child_id = relation.at_css("child").attr("node_id")
      parent = @knowledge_space_nodes_id_hash[parent_id]
      child = @knowledge_space_nodes_id_hash[child_id]
      add_relation(parent, child)
    end
  end

  def _build_root_nodes
    @root_nodes = @knowledge_space_nodes.select do |node|
      node.parents.length == 0
    end
  end

  def _build_knowledge_space_nodes
    @doc.css("KnowledgeSapceNet nodes node").each do |node|
      space_node_id = node.attr("id")

      knowledge_nodes = []
      node.css('knowledge_node_ids id').each do |id_node|
        node_id = id_node.text()
        knowledge_nodes << @knowledge_net.find_node_by_id(node_id)
      end

      node = KnowledgeSpaceNode.new(space_node_id, knowledge_nodes)
      add_node(node)
    end
  end
end