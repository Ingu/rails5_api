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

    it 'with ceo' do
      employee = Employee.new(first_name: 'Foo', last_name: 'Bar', social_number: '123456789')
      subject.ceo = employee
      expect(subject.ceo).to eq employee
    end

    it 'with employee' do
      employee = Employee.new(first_name: 'Foo', last_name: 'Bar', social_number: '123456789')
      subject.hireEmployee employee
      expect(subject.employees.size).to eq 1
    end

    it 'with two employees' do
      employee = Employee.new(first_name: 'Foo', last_name: 'Bar', social_number: '123456789')
      employee2 = Employee.new(first_name: 'Foo', last_name: 'Bar', social_number: '123456789')
      subject.hireEmployee employee
      subject.hireEmployee employee2
      expect(subject.employees.size).to eq 2
    end

    it 'can fire employee' do
      employee = Employee.new(first_name: 'Foo', last_name: 'Bar', social_number: '123456789')
      subject.employees << employee
      subject.fireEmployee(employee)
      expect(subject.employees.size).to eq 0
    end
  end
end
