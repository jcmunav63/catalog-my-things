require 'date'

class Item
  def initialize(genre, author, source, label, publish_date)
    @id = Random.rand(1..1000)
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?()
    today = Date.today
    if (today - @publish_date > 3650)
      @archived = true
    else
      @archived = falsee
  end

  def move_to_archived()
    @archived = can_be_archived?
  end
end
