class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, **args)
    super(**args)
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?()
    super || @cover_state == 'bad'
  end
end