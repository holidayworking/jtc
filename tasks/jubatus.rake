require 'pp'

namespace :jubatus do
  desc 'Updates server config at ALL servers'
  task :set_config do
    classifier = Classifier.new
    classifier.set_config
  end

  desc 'Getting server config from a server chosen randomly'
  task :get_config do
    classifier = Classifier.new
    pp classifier.get_config
  end
end
