require 'rails_helper'

RSpec.describe CompanyEmployeesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:company_attributes) { {
    name: 'Company Name',
    sector: 'Foo sector',
    industry: 'Bar industry'
  } }

  let(:employee_attributes) { {
    first_name: 'Foo',
    last_name: 'Bar',
    social_number: 'ABCDEFGHI'
  } }

  let(:invalid_employee_attributes) { {
    social_number: 'longer_then_9'
  } }

  let(:unprocessable_entity) { 422 }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompaniesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'gets all company employees json' do
      company = Company.create! company_attributes
      company.employees << Employee.create!(employee_attributes)
      company.employees << Employee.create!(employee_attributes)
      get :index, params: {company_id: company.id}, session: valid_session
      expect(response.body).to eq(company.employees.to_json)
    end
  end

  describe 'GET #show' do
    it 'gets the requested company employee json' do
      company = Company.create! company_attributes
      employee = Employee.create!(employee_attributes)
      company.employees << employee
      get :show, params: {company_id: company.id, id: employee.id}, session: valid_session
      expect(response.body).to eq(employee.to_json)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new employee for company' do
        company = Company.create! company_attributes
        expect(company.employees.size).to eq 0
        post :create, params: {company_id: company.id, employee: employee_attributes}, session: valid_session
        company.reload
        expect(company.employees.size).to eq 1
      end

      it 'adds existing employee to company' do
        company = Company.create! company_attributes
        employee = Employee.create!(employee_attributes)
        post :create, params: {company_id: company.id, employee: {id: employee.id}}, session: valid_session
        company.reload
        expect(company.employees.size).to eq 1
        expect(company.employees.include?(employee)).to be_truthy
      end
    end

    context 'with invalid params' do
      it 'gets unprocessable_entity status' do
        company = Company.create! company_attributes
        post :create, params: {company_id: company.id, employee: invalid_employee_attributes}, session: valid_session
        expect(response.status).to be unprocessable_entity
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { {
        first_name: 'new name'
      } }

      it 'updates the requested company employee' do
        company = Company.create! company_attributes
        employee = Employee.create!(employee_attributes)
        company.employees << employee
        put :update, params: {company_id: company.id, id: employee.id, employee: new_attributes}, session: valid_session
        employee.reload
        expect(employee.first_name).to eq('new name')
      end
    end

    context 'with invalid params' do
      it 'gets unprocessable_entity status' do
        company = Company.create! company_attributes
        employee = Employee.create!(employee_attributes)
        company.employees << employee
        put :update, params: {company_id: company.id, id: employee.id, employee: invalid_employee_attributes}, session: valid_session
        expect(response.status).to be unprocessable_entity
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested company employee' do
      company = Company.create! company_attributes
      employee = Employee.create!(employee_attributes)
      company.employees << employee
      delete :destroy, params: {company_id: company.id, id: employee.id}, session: valid_session
      company.reload
      expect(company.employees).to be_empty
    end
  end
end
