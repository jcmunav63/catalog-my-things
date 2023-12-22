require_relative '../label'

describe Label do
  before(:each) do
    @label = Label.new(1, 'Fantasy', 'Red')
  end

  describe '#initialize' do
    it 'is an instance of Label' do
      expect(@label).to be_an_instance_of(Label)
    end

    it 'initializes with correct attributes' do
      expect(@label.id).to eq(1)
      expect(@label.title).to eq('Fantasy')
      expect(@label.color).to eq('Red')
      expect(@label.items).to eq([])
    end
  end

  describe '#add_item' do
    let(:item) { instance_double('Item', label: nil) }

    before do
      allow(item).to receive(:label=).with(anything)
    end

    it 'adds an item to the items array' do
      @label.add_item(item)
      expect(@label.items).to include(item)
    end

    it 'does not add the same item twice' do
      @label.add_item(item)
      @label.add_item(item)
      expect(@label.items.size).to eq(1)
    end

    it 'sets the item\'s label to self' do
      @label.add_item(item)
      expect(item).to have_received(:label=).with(@label)
    end

    it 'does not change the item\'s label if it is already set to this label' do
      allow(item).to receive(:label).and_return(@label)
      @label.add_item(item)
      expect(item).not_to have_received(:label=).with(@label)
    end
  end
end
