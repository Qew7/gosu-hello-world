class Player < GameEntity
  COLOR = 0xff_308000
  IMAGE_PATH = 'src/media/player.png'

  attr_reader :score

  def initialize(window, x, y)
    @images = Gosu::Image.load_tiles(IMAGE_PATH, 40, 50)
    @window = window
    @x = x
    @y = y
    @score = Score.new(window)
    window.objects << @score
  end

  def update
    move(:left) if Gosu.button_down?(Gosu::KB_LEFT)
    move(:right) if Gosu.button_down?(Gosu::KB_RIGHT)
    move(:up) if Gosu.button_down?(Gosu::KB_UP)
    move(:down) if Gosu.button_down?(Gosu::KB_DOWN)
    collect_cats(cats)
  end

  def draw
    @images[Gosu.milliseconds / 200 % 2].draw(x - 10, y - 20, 1, 0.5, 0.5, COLOR)
    @images[2].draw_rot(x, y - 5, 1, 90, 1, 0.5, 0.5, 1.0, COLOR)
  end

  private

  def cats
    window.objects.select { |obj| obj.cat? }
  end

  def collect_cats(cats)
    cats.each do |cat|
      collect_cat(cat) if Gosu.distance(x, y, cat.x, cat.y) < 30
    end
  end

  def collect_cat(cat)
    cat.collected
    score.add(1)
  end

  def move(dir)
    case dir
    when :down
      @y += 1 unless y >= window.height
    when :up
      @y -= 1 unless y <= 0
    when :left
      @x -= 1 unless x <= 0
    when :right
      @x += 1 unless x >= window.width
    end
  end
end
