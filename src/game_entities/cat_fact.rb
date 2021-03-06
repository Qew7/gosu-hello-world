class CatFact < GameEntity
  attr_reader :cat_api_client

  def initialize
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
