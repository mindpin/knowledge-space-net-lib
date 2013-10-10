require 'spec_helper'

describe KnowledgeNet do
  let(:path){"config/knowledge_nets/1.xml"}
  let(:knowledge_net){KnowledgeNet.load_xml_file(path)}

  it 'self.load_xml_file(file_path)' do
    KnowledgeNet.load_xml_file(path).knowledge_nodes.count.should be 3
  end

  it 'root_nodes' do
    knowledge_net.root_nodes.first.id.should == 'k1'
  end

  it 'find_node_by_id(node_id)' do
    knowledge_net.find_node_by_id('k2').name.should == 'xxx 3'
  end
end