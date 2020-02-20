class Cat
  def initialize(window, x, y)
    @window = window
    @x = x
    @y = y
    @image = cat_image
  end

  private

  def cat_image
    url = CatImagesApiClient.new.cat_image_url
    File.open('src/media/cat.jpg', 'wb') do |fo|
      fo.write(URI.open(url))
    end
    Gosu::Image.new('src/media/cat.jpg')
  end
end
