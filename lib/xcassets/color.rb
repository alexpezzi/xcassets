require 'fileutils'

module XCAssets
  class Color
    attr_reader :hexcolor, :color_space, :idiom

    def initialize(hexcolor, color_space: "srgb", idiom: nil)
      @hexcolor = hexcolor
      @color_space = color_space
      @idiom = idiom || "universal"
      @red, @green, @blue, @alpha = rgb_hex_to_dec(hexcolor)
    end

    def contents
      {
        color: {
          "color-space": @color_space,
          components: {
            alpha: @alpha.to_s,
            blue: @blue.to_s,
            green: @green.to_s,
            red: @red.to_s
          }
        },
        idiom: @idiom.to_s
      }.compact
    end

    def rgb_hex_to_dec(color)
      # This method converts an RGB or RGBA color from hexadecimal format to
      # values of RED, GREEN, BLUE and ALPHA between 0.0 and 1.0
      color = color.sub("#", "")
      color = color.sub("0x", "")
      color_int = color.to_i(16)

      if color.length == 6
        red = ((color_int & 0xFF0000) >> 16) / 255.0
        green = ((color_int & 0x00FF00) >> 8) / 255.0
        blue = ((color_int & 0x0000FF) >> 0) / 255.0
        alpha = 1.0
      elsif color.length == 8
        red = ((color_int & 0xFF000000) >> 24) / 255.0
        green = ((color_int & 0x00FF0000) >> 16) / 255.0
        blue = ((color_int & 0x0000FF00) >> 8) / 255.0
        alpha = ((color_int & 0x000000FF) >> 0) / 255.0
      end

      return red, green, blue, alpha
    end
  end
end
