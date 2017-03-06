require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:valid_attributes) { {
    first_name: 'Foo',
    last_name: 'Bar',
    social_number: 'ABCDEFGHI'
  } }

  subject {
    described_class.new(valid_attributes)
  }

  describe '#create new employee' do
    it 'with proper values' do
      expect(subject.first_name).to eq 'Foo'
      expect(subject.last_name).to eq 'Bar'
      expect(subject.social_number).to eq 'ABCDEFGHI'
    end
  end
end
