require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:valid_attributes) { {
    name: 'Company Name',
    sector: 'Foo sector',
    industry: 'Bar industry'
  } }

  subject {
    described_class.new(valid_attributes)
  }

  describe '#create new company' do
    it 'with proper values' do
      expect(subject.name).to eq 'Company Name'
      expect(subject.sector).to eq 'Foo sector'
      expect(subject.industry).to eq 'Bar industry'
    end
  end

  describe 'add ceo' do
    it '' do
      employee= Employee.new(first_name: 'Foo', last_name: 'Bar')
      subject.ceo = employee
    end
  end
end
