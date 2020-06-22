require 'test_helper'

class ColorsetTest < Minitest::Test
    
  def setup
    @colorset = XCAssets::Colorset.new('name')
    color = XCAssets::Color.new("#FFFFFFFF")
    @colorset.add(color)
  end

  def test_contents
    assert_equal @colorset.contents,
                 colors: [
                     {
                         color: {
                             "color-space": "srgb",
                             components: {
                                 alpha: "1.0",
                                 blue: "1.0",
                                 green: "1.0",
                                 red: "1.0"
                             }
                         },
                         idiom: "universal"
                     }
                 ],
                 info: { author: 'xcassets', version: 1 }
  end

  def test_save
    Dir.mktmpdir do |dir|
        @colorset.save(dir)
        path = File.join(dir, 'name.colorset')
        assert Dir.exist?(path)
        assert File.exist?(File.join(path, 'Contents.json')) 
    end
  end
end
