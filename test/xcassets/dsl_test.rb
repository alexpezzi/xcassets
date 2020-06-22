require 'test_helper'

class DSLTest < Minitest::Test
  include XCAssets::DSL

  def test_scinario
    assets = xcassets 'Assets' do
      imageset 'app-logo', properties: { "template-rendering-intent": "template" } do
        image fixture('app_logo.pdf')
      end
      imageset 'splashScreenFullscreenImage' do
        image fixture('splashScreenFullscreenImage.pdf')
      end
      imageset 'splashScreenLogo' do
        image fixture('splashScreenLogo-iPhone.pdf'), idiom: "iphone"
        image fixture('splashScreenLogo-iPad.pdf'), idiom: "ipad"
      end
      imageset 'splashScreenLogo2' do
        image fixture('splashScreenLogo-iPhone@2x.png'), idiom: "iphone", scale: 2
        image fixture('splashScreenLogo-iPhone@3x.png'), idiom: "iphone", scale: 3
        image fixture('splashScreenLogo-iPad@2x.png'), idiom: "ipad", scale: 2
      end
      colorset 'backgroundColor' do
        color '#FF0000FF', idiom: "iphone"
        color '#00FF00FF', idiom: "ipad"
        color '#0000FFFF', idiom: "tv"
        color '#88888888', idiom: "mac"
      end
    end
    assets.save(Dir.pwd)
  end
end
