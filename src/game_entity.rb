class GameEntity
  IMAGE_PATH = ''

  attr_reader :x, :y, :window, :image

  def update
    raise NotImplementedError
  end

  def draw
    raise NotImplementedError
  end
end
