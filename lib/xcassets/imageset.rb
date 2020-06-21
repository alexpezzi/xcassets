require 'json'

module XCAssets
  class Imageset
    attr_reader :name, :properties, :author, :version, :images

    def initialize(name, properties: {}, author: 'xcassets', version: 1)
      @name = name
      @properties = properties
      @images = []
      @author = author
      @version = version
    end

    def info
      { author: @author, version: @version }
    end

    def contents
      @images.each_with_object(info: info, images: []) { |image, hash|
        hash[:images] << image.contents
      }.compact.delete_if { |k, v| v.empty? }
    end

    def add(image)
      @images << image
    end

    def save(parent_path)
      path = File.join(parent_path, "#{name}.imageset")
      Dir.mkdir(path)
      @images.each do |image|
        image.save(path)
      end
      json_path = File.join(path, 'Contents.json')
      File.open(json_path, 'w') do |file|
        file << JSON.pretty_generate(contents)
      end
    end
  end
end
