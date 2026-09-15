require_relative 'lib/usa/version'

Gem::Specification.new do |spec|
  spec.name        = 'usa'
  spec.version     = USA::VERSION
  spec.authors     = [ 'Claudio Baccigalupo' ]
  spec.email       = [ 'claudiob@users.noreply.github.com' ]
  spec.homepage    = 'https://github.com/claudiob/usa'
  spec.summary     = 'The geography of the United States'
  spec.description = 'Every state, county, city and ZIP, as tables a Rails app joins to'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/claudiob/usa/'
  spec.metadata['changelog_uri']     = 'https://github.com/claudiob/usa/blob/main/CHANGELOG.md'
  spec.metadata['documentation_uri'] = 'https://rubydoc.info/gems/usa'
  spec.required_ruby_version         = '>= 3.2.0'

  spec.files = `git ls-files -z app db lib CHANGELOG.md LICENSE.txt README.md`.split "\x0"

  spec.add_dependency 'csv' # a seed has no file format to read since Ruby unbundled it
  spec.add_dependency 'rails' # the models are not autoloaded and the tables have no prefix
end
