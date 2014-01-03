require 'nokogiri'

module KnowledgeSpaceNetLib
  class KnowledgeNet
    attr_accessor :name, :sets, :checkpoints

    def initialize(doc, name)
      @name = name
      @doc = doc
      @id = doc.at_css("knowledge-field").attr("id")
      @set_hash = {}
      @node_hash = {}
      @checkpoint_hash = {}

      @sets = []
      @checkpoints = []
      @nodes = []


      _build_sets()
      _build_checkpoints()
      _build_set_and_checkpoint_relation()
    end

    def _build_sets
      @doc.css("sets set").each do |set_dom|
        set = KnowledgeSet.new(
          :set_id => set_dom.attr("id"),
          :name   => set_dom.attr("name"),
          :icon   => set_dom.attr("icon"),
          :deep   => set_dom.attr("deep").to_i
        )
        @set_hash[set.set_id] = set
        @sets << set

        _build_nodes(set, set_dom)
        _build_node_relations(set, set_dom)
      end
    end

    def _build_checkpoints
      @doc.css("checkpoints checkpoint").each do |checkpoint_dom|
        learned_sets = checkpoint_dom.css("learned").map do |dom|
          find_set_by_id(dom.attr("target"))
        end
        checkpoint = KnowledgeCheckpoint.new(
          :checkpoint_id => checkpoint_dom.attr("id"),
          :deep          => checkpoint_dom.attr("deep"),
          :learned_sets  => learned_sets
        )
        @checkpoint_hash[checkpoint.checkpoint_id] = checkpoint
        @checkpoints << checkpoint
      end
    end

    def _build_set_and_checkpoint_relation
      @doc.css("relations parent-child").each do |relation_dom|
        _add_relation(
          :parent => relation_dom.attr("parent"),
          :child  => relation_dom.attr("child")
        )
      end
    end

    def _add_relation(params)
      parent = find_set_by_id(params[:parent]) || find_checkpoint_by_id(params[:parent])
      child  = find_set_by_id(params[:child]) || find_checkpoint_by_id(params[:child])
      parent.add_child(child)
    end

    def _build_nodes(set, set_dom)
      set_dom.css("nodes node").each do |node_dom|
        node = KnowledgeNode.new(
          :set      => set,
          :node_id  => node_dom.attr("id"),
          :name     => node_dom.attr("name"),
          :required => node_dom.attr("required") == "true",
          :desc     => node_dom.at_css("desc").text
        )
        @node_hash[node.node_id] = node
        @nodes << node
      end
    end

    def _build_node_relations(set, set_dom)
      set_dom.css("nodes-relations parent-child").each do |relation_dom|
        _add_node_relation(
          :parent => relation_dom.attr("parent"),
          :child  => relation_dom.attr("child")
        )
      end
    end

    def _add_node_relation(params)
      parent = find_node_by_id(params[:parent])
      child = find_node_by_id(params[:child])
      parent.add_child(child)
    end

    def find_set_by_id(set_id)
      @set_hash[set_id]
    end

    def find_checkpoint_by_id(checkpoint_id)
      @checkpoint_hash[checkpoint_id]
    end

    def find_node_by_id(node_id)
      @node_hash[node_id]
    end

    def root_sets
      kns = []
      self.sets.each do |v|
        kns << v if v.is_root?
      end
      kns
    end

    def self.load_xml_file(file_path)
      path = File.join(KnowledgeSpaceNetLib::BASE_PATH, file_path)
      doc = Nokogiri::XML(File.open(path))
      name = File.basename(path,".xml")
      KnowledgeNet.new(doc, name)
    end

    def self.all
      KnowledgeSpaceNetLib::DATA.values
    end

    def self.get_by_name(name)
      KnowledgeSpaceNetLib::DATA[name]
    end


  end
end