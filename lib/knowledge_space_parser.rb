class KnowledgeSpaceParser
  class << self
    def load(knowledge_net, space_net_xml_path)
      doc = Nokogiri::XML(File.open(space_net_xml_path))
      KnowledgeSpaceNet.new(knowledge_net, doc)
    end

    def parse(knowledge_net)
      knowledge_space_net = KnowledgeSpaceNet.new(knowledge_net)
      
      knowledge_space_net.knowledge_space_nodes = []

      # 第一步，先取得知识网络中所有的初始节点
      # 分别构建第一批知识空间节点
      root_nodes = knowledge_net.root_nodes
    end
  end
end
