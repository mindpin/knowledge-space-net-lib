require 'nokogiri'

module KnowledgeSpaceNetLib
  class KnowledgeNet
    attr_accessor :id, :name, :sets, :nodes, :checkpoints, :relations

    def initialize(doc, id, name)
      @id   = id
      @name = name
      @doc = doc
      @set_hash = {}
      @node_hash = {}
      @checkpoint_hash = {}

      @sets = []
      @checkpoints = []
      @relations = []
      @nodes = []


      _build_sets()
      _build_checkpoints()
      _build_base_set_relation()
    end

    def _build_sets
      @doc.css("sets set").each do |set_dom|
        set = KnowledgeSet.new(
          :net    => self,
          :id     => set_dom.attr("id"),
          :name   => set_dom.attr("name"),
          :icon   => set_dom.attr("icon"),
          :deep   => set_dom.attr("deep").to_i
        )
        @set_hash[set.id] = set
        @sets << set

        _build_nodes(set, set_dom)
        _build_node_relations(set, set_dom)
      end
    end

    def _build_checkpoints
      @doc.css("checkpoints checkpoint").each do |checkpoint_dom|
        learned_set_ids = checkpoint_dom.css("learned").map do |dom|
          dom.attr("target")
        end
        checkpoint = KnowledgeCheckpoint.new(
          :net           => self,
          :id            => checkpoint_dom.attr("id"),
          :deep          => checkpoint_dom.attr("deep"),
          :learned_set_ids  => learned_set_ids
        )
        @checkpoint_hash[checkpoint.id] = checkpoint
        @checkpoints << checkpoint
      end
    end

    def _build_base_set_relation
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
      @relations << BaseKnowledgeSetRelation.new(:parent => parent, :child => child)
    end

    def _build_nodes(set, set_dom)
      set_dom.css("nodes node").each do |node_dom|
        node = KnowledgeNode.new(
          :net      => self,
          :set_id   => set.id,
          :id       => node_dom.attr("id"),
          :name     => node_dom.attr("name"),
          :required => node_dom.attr("required") == "true",
          :desc     => node_dom.at_css("desc").text
        )
        set.add_node(node)
        @node_hash[node.id] = node
        @nodes << node
      end
    end

    def _build_node_relations(set, set_dom)
      set_dom.css("nodes-relations parent-child").each do |relation_dom|
        _add_node_relation(
          set,
          :parent => relation_dom.attr("parent"),
          :child  => relation_dom.attr("child")
        )
      end
    end

    def _add_node_relation(set, params)
      parent = find_node_by_id(params[:parent])
      child = find_node_by_id(params[:child])
      parent.add_child(child)
      set.add_relation(BaseKnowledgeNodeRelation.new(:parent => parent, :child => child))
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

    def find_set_or_checkpoint_by_id(id)
      find_set_by_id(id) || find_checkpoint_by_id(id)
    end

    def root_sets
      kns = []
      self.sets.each do |v|
        kns << v if v.is_root?
      end
      kns
    end

    def self.load_xml_file(file_path, name)
      path = File.join(KnowledgeSpaceNetLib::BASE_PATH, file_path)
      doc = Nokogiri::XML(File.open(path))
      id = File.basename(path,".xml")
      KnowledgeNet.new(doc, id, name)
    end

    def self.all
      KnowledgeSpaceNetLib::DATA.values
    end

    def self.find(id)
      KnowledgeSpaceNetLib::DATA[id]
    end

  end
end