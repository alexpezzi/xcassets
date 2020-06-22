require 'test_helper'

class ColorTest < Minitest::Test
  def setup
    @color = XCAssets::Color.new("#FFFFFFFF")
  end

  def test_contents
    assert_equal @color.contents, color: {
                                    "color-space": "srgb",
                                    components: {
                                        alpha: "1.0",
                                        blue: "1.0",
                                        green: "1.0",
                                        red: "1.0"
                                    }
                                  },
                                  idiom: 'universal'
  end
end
