require_relative 'item'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(args = {})
    super(args[:genre], args[:author], args[:source], args[:label], args[:publish_date])
    @on_spotify = args[:on_spotify]
  end

  def can_be_archived?
    super && @on_spotify
  end
end
