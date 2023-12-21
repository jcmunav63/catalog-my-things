require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(**args)
    super(args[:id], args[:genre], args[:author],
      args[:source], args[:label], args[:publish_date])
    @multiplayer = args[:multiplayer]
    @last_played_at = args[:last_played_at]
  end

  def can_be_archived?
    super && (Time.now.year - @last_played_at.year > 2)
  end
end
