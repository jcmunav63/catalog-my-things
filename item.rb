require_relative 'label'

class Item
  attr_accessor :genre, :author, :source, :label
  attr_reader :id, :publish_date
  attr_writer :archived

  def initialize(genre, author, source, label, publish_date)
    @id = id
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
    @archived = false
    label&.add_item(self)
  end

  def can_be_archived?()
    Time.now.year - @publish_date.year > 10
  end

  def move_to_archive()
    @archived = true if can_be_archived?
  end
end
