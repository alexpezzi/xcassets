require 'json'

module XCAssets
  class Colorset
    attr_reader :name, :author, :version, :colors

    def initialize(name, author: 'xcassets', version: 1)
      @name = name
      @colors = []
      @author = author
      @version = version
    end

    def info
      { author: @author, version: @version }
    end

    def contents
      @colors.each_with_object(info: info, colors: []) { |color, hash|
        hash[:colors] << color.contents
      }.compact.delete_if { |k, v| v.empty? }
    end

    def add(color)
      @colors << color
    end

    def save(parent_path)
      path = File.join(parent_path, "#{name}.colorset")
      Dir.mkdir(path)
      json_path = File.join(path, 'Contents.json')
      File.open(json_path, 'w') do |file|
        file << JSON.pretty_generate(contents)
      end
    end
  end
end
