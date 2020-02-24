class Score < GameEntity
  attr_reader :image, :scores_height, :score

  def initialize(window)
    @window = window
    @score = 0
    @scores_height = window.height / 10
    @image = Gosu::Image.from_text(@score.to_i, @scores_height)
    @x = window.width - @image.width
    @y = window.height - @image.height
  end

  def update
    update_score_image
  end

  def draw
    image.draw(x, y, 4)
  end

  def add(points)
    @score += points
  end

  private

  def update_score_image
    @current_score ||= @score
    if @current_score != @score
      @image = Gosu::Image.from_text(score.to_i, scores_height)
      @x = window.width - image.width
      @current_score = @score
    end
  end
end
