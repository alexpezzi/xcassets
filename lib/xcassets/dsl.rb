require 'xcassets'

module XCAssets
  module DSL
    def xcassets(name, **options, &block)
      @assets = ::XCAssets::XCAssets.new(name, **options)
      instance_eval(&block)
      @assets
    end

    def iconset(name, **options, &block)
      @set = ::XCAssets::Iconset.new(name, **options)
      @assets.add(@set) if @assets
      instance_eval(&block)
      @set
    end

    def imageset(name, **options, &block)
      @set = ::XCAssets::Imageset.new(name, **options)
      @assets.add(@set) if @assets
      instance_eval(&block)
      @set
    end

    def colorset(name, **options, &block)
      @set = ::XCAssets::Colorset.new(name, **options)
      @assets.add(@set) if @assets
      instance_eval(&block)
      @set
    end

    def image(source, **options)
      source, options[:filename] = source.first if source.is_a?(Hash)
      image = ::XCAssets::Image.new(source, **options)
      @set.add(image)
      image
    end

    def color(hexcolor, **options)
      color = ::XCAssets::Color.new(hexcolor, **options)
      @set.add(color)
      color
    end

    def images(*filenames)
      filenames.flat_map { |filename| Dir.glob(filename) }
               .each { |filename| image(filename) }
    end
  end
end
