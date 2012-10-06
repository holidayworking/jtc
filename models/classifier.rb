require 'json'
require 'jubatus/classifier/client'
require 'jubatus/classifier/types'

class Classifier
  def initialize
    converter = {
      'string_filter_types' => {},
      'string_filter_rules' => [],
      'num_filter_types' => {},
      'num_filter_rules' => [],
      'string_types' => {
        'mecab' => {
          'method' => 'dynamic',
          'path' => '/usr/local/lib/libmecab_splitter.so',
          'function' => 'create'
        }
      },
      'string_rules' => [
        { 'key' => '*', 'type' => 'mecab', 'sample_weight' => 'bin', 'global_weight' => 'bin' }
      ],
      'num_types' => {},
      'num_rules' => []
    }

    @config = Jubatus::Config_data.new(JUBATUS[:algorithm], JSON.generate(converter))
    @classifier = Jubatus::Client::Classifier.new(JUBATUS[:host], JUBATUS[:port])
  end

  def set_config
    @classifier.set_config(JUBATUS[:name], @config)
  end

  def get_config
    @classifier.get_config(JUBATUS[:name])
  end

  def train(content, category)
    datum = Jubatus::Datum.new([['content', content]], [])
    @classifier.train(JUBATUS[:name], [[category, datum]])
    @classifier.save(JUBATUS[:name], 'jtc')
  end

  def classify(content)
    @classifier.load(JUBATUS[:name], 'jtc')
    datum = Jubatus::Datum.new([['content', content]], [])
    return @classifier.classify(JUBATUS[:name], [datum]).first
  end
end
