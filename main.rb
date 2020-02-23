require 'open-uri'
require 'gosu'
require 'httparty'
require 'pry'
require_relative 'src/hello_world'

WIDTH, HEIGHT = 800, 600

class HelloWorld < Gosu::Window
  def initialize
    super WIDTH, HEIGHT

    self.caption = 'HW: Random Cat Facts'
    @player = Player.new(self, WIDTH / 2, (HEIGHT / 2) - 30)
    cat_fact = CatFact.new
    @objects = []
    @objects << @player
    @objects << cat_fact
  end

  def update
    @objects.each { |obj| obj.update }
    if Gosu.milliseconds % 500 == 0
      @objects << Cat.new(self, rand(0..HEIGHT), rand(0..WIDTH))
    end
  end

  def draw
    @objects.each {|obj| obj.draw }
  end
end

HelloWorld.new.show
