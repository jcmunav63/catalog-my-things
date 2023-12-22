require_relative 'label'
require_relative 'author'
require_relative 'genre'

class Item
  attr_accessor :genre, :author, :source, :label, :archived
  attr_reader :id, :publish_date

  def initialize(id, genre, author, source, label, publish_date) # rubocop:disable Metrics/ParameterLists
    @id = id
    @genre = genre
    @author = author
    @source = source
    @label = label
    @publish_date = publish_date
    @archived = false
    label&.add_item(self)
    author&.add_item(self)
    genre&.add_item(self)
  end

  def can_be_archived?()
    Time.now.year - @publish_date.year > 10
  end

  def move_to_archive()
    @archived = true if can_be_archived?
  end
end
