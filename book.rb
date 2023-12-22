class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(**args)
    super(args[:id], args[:genre], args[:author], args[:source],
          args[:label], args[:publish_date])
    @publisher = args[:publisher]
    @cover_state = args[:cover_state]
  end

  def can_be_archived?()
    super || @cover_state.downcase == 'bad'
  end
end
