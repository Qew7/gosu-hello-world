class Player
  COLOR = 0xff_308000

  attr_reader :x, :y, :window

  def initialize(window, x, y)
    @images = Gosu::Image.load_tiles('src/media/player.png', 40, 50)
    @window = window
    @x = x
    @y = y
    @vy = 0
    @vx = 0
  end

  def update
    @vy.times { @y += 1 } if @vy > 1
    @vx.times { @x += 1 } if @vx > 1
  end

  def draw
    @images[Gosu.milliseconds / 200 % 2].draw(x - 10, y - 20, 0, 0.5, 0.5, COLOR)
    @images[2].draw_rot(x, y - 5, 0, 90, 1, 0.5, 0.5, 1.0, COLOR)
  end

  def move(dir)
    case dir
    when :down
      @y += 1 unless @y >= window.height
    when :up
      @y -= 1 unless @y <= 0
    when :left
      @x -= 1 unless @x <=0
    when :right
      @x += 1 unless @x >= window.width
    end
  end
end
