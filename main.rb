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
    @image_text = Gosu::Image.from_text((cat_api_client.cat_fact || 'Hello World'), 20, # This part is a problem, it constantly creates new Gosu::Image objects
                                        bold: [true, false].sample,
                                        italic: [true, false].sample,
                                        width: 400)
    p ObjectSpace.each_object(Gosu::Image).count
  end

  def draw
    @image_text.draw_rot(WIDTH / 2, HEIGHT / 2, 0, Math.cos(Gosu.milliseconds / 130))
  end
end

class CatApiClient
  include HTTParty

  base_uri 'meowfacts.herokuapp.com'

  def cat_fact
    @time ||= Time.now
    if @fact.nil? || (Time.now - @time).to_i > 10
      response = self.class.get('')
      @time = Time.now
      @fact = JSON.parse(response.body)['data'].first if response.code == 200
    else
      @fact
    end
  end
end

HelloWorld.new.show
