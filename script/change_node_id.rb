# 用法：

# ruby change_node_id.rb <原节点ID> <新节点ID>
# ruby change_node_id.rb javascript.xml node-2 node-111


# 如果指定的新节点ID已存在，会有提示：

# ···
# ruby change_node_id.rb javascript.xml node-1 node-3
# 指定的新节点ID已存在，不能转换
# ···

require 'rubygems'
require 'nokogiri'
 
class KnowledgeXmlNodeIdChanger
  @xml_file_path
 
  def initialize(xml_file_path)
    @xml_file_path = xml_file_path
 
    str = File.new(@xml_file_path).read
    @file_xml = Nokogiri::XML str
  end
 
  def change_id(old_node_id, new_node_id)
    output_file_path = @xml_file_path + ".changed"
 
    if @file_xml.css("node[id='#{new_node_id}']").length > 0
      puts "指定的新节点ID已存在，不能转换"
      return 
    end
 
    @file_xml.css("node[id='#{old_node_id}']").each do |node|
      node['id'] = new_node_id
    end
 
    @file_xml.css("parent-child[parent='#{old_node_id}']").each do |node|
      node['parent'] = new_node_id
    end
 
    @file_xml.css("parent-child[child='#{old_node_id}']").each do |node|
      node['child'] = new_node_id
    end
 
    output_str = @file_xml.to_xml(:encoding => 'UTF-8')
 
    File.open(output_file_path, 'w') { |f|
      f.write(output_str)
    }
  end
end
 
xml_file_path = ARGV[0]
old_node_id = ARGV[1]
new_node_id = ARGV[2]
 
if !xml_file_path || !old_node_id || !new_node_id
  p '参数不正确，请按 ruby change_node_id.rb <xml文件> <原节点ID> <新节点ID> 来执行'
  exit(0)
end
 
KnowledgeXmlNodeIdChanger.new(xml_file_path).change_id(old_node_id, new_node_id)