class Cat < GameEntity
  IMAGE_PATH = 'src/media/cat.jpg'

  attr_reader :image_width, :image_height

  def initialize(window)
    @window = window
    @image = cat_image
    @image_width = window.width / 5
    @image_height = window.height / 5
    @x = rand((@image_width / 3)..(window.width - @image_width / 3))
    @y = rand((@image_height / 3)..(window.height - @image_height / 3))
  end

  def update; end

  def draw
    scale_x = image_width.to_f / image.width
    scale_y = image_height.to_f / image.height
    image.draw_rot(x, y, 0, Math.sin(Gosu.milliseconds / 200), 0.5, 0.5, scale_x, scale_y)
  end

  def cat?
    true
  end

  def collected
    window.objects.delete(self)
  end

  private

  def cat_image
    url = CatImagesApiClient.new.cat_image_url
    File.open(IMAGE_PATH, 'wb') do |fo|
      fo.write(URI.open(url).read)
    end
    Gosu::Image.new(IMAGE_PATH, retro: true)
  end
end
