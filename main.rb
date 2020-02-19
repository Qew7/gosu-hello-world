require 'gosu'
require 'httparty'
require 'pry'
require_relative 'src/hello_world'

WIDTH, HEIGHT = 640, 480

class HelloWorld < Gosu::Window
  attr_reader :cat_api_client

  def initialize
    super WIDTH, HEIGHT

    self.caption = 'HW: Random Cat Facts'
    @cat_api_client = CatApiClient.new
    @player = Player.new(self, WIDTH / 2, (HEIGHT / 2) - 30)
  end

  def update
    @player.move(:left) if Gosu.button_down?(Gosu::KB_LEFT)
    @player.move(:right) if Gosu.button_down?(Gosu::KB_RIGHT)
    @player.move(:up) if Gosu.button_down?(Gosu::KB_UP)
    @player.move(:down) if Gosu.button_down?(Gosu::KB_DOWN)
    @time ||= Time.now
    if Gosu.button_down?(Gosu::KB_RETURN) || @fact.nil? || (Time.now - @time).to_i > 10
      update_text
      @time = Time.now
    end
  end

  def draw
    @player.draw
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

HelloWorld.new.show
