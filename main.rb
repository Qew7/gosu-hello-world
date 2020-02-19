require 'gosu'
require 'httparty'

WIDTH, HEIGHT = 640, 480

class HelloWorld < Gosu::Window
  attr_reader :cat_api_client

  def initialize
    super WIDTH, HEIGHT

    self.caption = 'HW: Random Cat Facts'
    @cat_api_client = CatApiClient.new
  end

  def update
    @time ||= Time.now
    if Gosu.button_down?(Gosu::KB_RETURN) || @fact.nil? || (Time.now - @time).to_i > 10
      update_text
      @time = Time.now
    end
  end

  def draw
    @image_text.draw_rot(WIDTH / 2, HEIGHT / 2, 0, Math.cos(Gosu.milliseconds / 130))
  end

  def update_text
    @fact = cat_api_client.cat_fact
    @image_text = Gosu::Image.from_text((@fact || 'Hello World'), 19,
                                        bold: [true, false].sample,
                                        italic: [true, false].sample,
                                        width: 399)
  end
end

class CatApiClient
  include HTTParty

  base_uri 'meowfacts.herokuapp.com'

  def cat_fact
    response = self.class.get('')
    JSON.parse(response.body)['data'].first if response.code == 200
  end
end

HelloWorld.new.show
