class KnowledgeSpaceParser
  class << self
    def load(knowledge_net,space_net_xml_path)
      doc = Nokogiri::XML(File.open(space_net_xml_path))
      KnowledgeSpaceNet.new(knowledge_net, doc)
    end
  end
end
