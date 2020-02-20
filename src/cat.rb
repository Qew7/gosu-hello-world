class Cat
  IMAGE_PATH = 'src/media/cat.jpg'
  SCALE = 0.125

  attr_reader :x, :y, :window, :image

  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @image = cat_image
  end

  def draw
    scale_x = SCALE * (image.width.to_f / window.width)
    scale_y = SCALE * (image.height.to_f / window.width)
    image.draw_rot(x, y, 0, Math.sin(Gosu.milliseconds / 200), 0.5, 0.5, scale_x, scale_y)
  end

  private

  def cat_image
    url = CatImagesApiClient.new.cat_image_url
    File.open(IMAGE_PATH, 'wb') do |fo|
      fo.write(open(url).read)
    end
    Gosu::Image.new(IMAGE_PATH, retro: true)
  end
end
