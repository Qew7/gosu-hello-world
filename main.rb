require 'open-uri'
require 'gosu'
require 'httparty'
require 'pry'
require_relative 'src/hello_world'

WIDTH, HEIGHT = 800, 600

class HelloWorld < Gosu::Window
  attr_reader :cat_api_client

  def initialize
    super WIDTH, HEIGHT

    self.caption = 'HW: Random Cat Facts'
    @cat_api_client = CatApiClient.new
    @player = Player.new(self, WIDTH / 2, (HEIGHT / 2) - 30)
    @objects = []
    @objects << @player
  end

  def update
    @objects.each { |obj| obj.update }
    milliseconds = Gosu.milliseconds
    if Gosu.button_down?(Gosu::KB_RETURN) || @fact.nil? || milliseconds % 1000 == 0
      update_text
    end
    if milliseconds % 500 == 0
      @objects << Cat.new(self, rand(0..HEIGHT), rand(0..WIDTH))
    end
  end

  def draw
    @objects.each {|obj| obj.draw }
    @image_text.draw_rot(WIDTH / 2, HEIGHT / 2, 2, Math.cos(Gosu.milliseconds / 130))
  end

  private

  def update_text
    @fact = cat_api_client.cat_fact
    @image_text = Gosu::Image.from_text((@fact || 'Hello World'), HEIGHT / 15,
                                        bold: [true, false].sample,
                                        italic: [true, false].sample,
                                        width: 399)
  end
end

HelloWorld.new.show
