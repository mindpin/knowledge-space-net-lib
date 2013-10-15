base_path = File.expand_path("../../",__FILE__)
$LOAD_PATH.unshift "#{base_path}/lib"
require "#{base_path}/lib/knowledge-space-net-lib"

input_file_name = ARGV[0]
input_file_path = "config/knowledge_nets/#{input_file_name}"
raise "#{input_file_path} 文件不存在" if !File.exists?(input_file_path)

file_name = File.basename(input_file_path)
build_file_path = File.join(base_path,"config/knowledge_space_nets/#{file_name}")

knowledge_net = KnowledgeNet.load_xml_file(input_file_path)
knowledge_space_net = KnowledgeSpaceParser.new(knowledge_net).parse
knowledge_space_net.save_to(build_file_path)
p "成功生成 #{build_file_path}"