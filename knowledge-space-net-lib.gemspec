Gem::Specification.new do |s|
  s.name = 'knowledge-space-net-lib'
  s.version = '0.0.1'
  s.platform = Gem::Platform::RUBY
  s.date = '2013-10-14'
  s.summary = 'knowledge-space-net-lib'
  s.description = 'knowledge-space-net-lib'
  s.authors = ['arlyxiao', 'fushang318']
  s.email = 'kingla_pei@163.com'
  s.homepage = 'https://github.com/mindpin/knowledge-space-net-lib'
  s.licenses = 'MIT'

  s.files = Dir.glob("lib/**/*") + %w(README.md)
  s.require_paths = ['lib']

  s.add_dependency 'nokogiri'
end