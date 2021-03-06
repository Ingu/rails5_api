require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Employee. As you add validations to Employee, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {
    first_name: 'Foo',
    last_name: 'Bar',
    social_number: 'ABCDEFGHI'
  } }

  let(:invalid_attributes) { {
    last_name: 'Bar',
    social_number: 'ABCDI'
  } }

  let(:unprocessable_entity) { 422 }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EmployeesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "gets all employees json" do
      employee = Employee.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response.body).to eq([employee].to_json)
    end
  end

  describe "GET #show" do
    it "get specific employee json" do
      employee = Employee.create! valid_attributes
      get :show, params: {id: employee.to_param}, session: valid_session
      expect(response.body).to eq(employee.to_json)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Employee" do
        expect {
          post :create, params: {employee: valid_attributes}, session: valid_session
        }.to change(Employee, :count).by(1)
      end
    end

    context "with invalid params" do
      it "get unprocessable_entity status" do
        post :create, params: {employee: invalid_attributes}, session: valid_session
        expect(response.status).to be unprocessable_entity
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {
        first_name: 'New Foo',
        last_name: 'New Bar'
      } }

      it "updates the requested employee" do
        employee = Employee.create! valid_attributes
        put :update, params: {id: employee.to_param, employee: new_attributes}, session: valid_session
        employee.reload
        expect(employee.first_name).to eq 'New Foo'
        expect(employee.last_name).to eq 'New Bar'
      end
    end

    context "with invalid params" do
      it "get unprocessable_entity status" do
        employee = Employee.create! valid_attributes
        put :update, params: {id: employee.to_param, employee: invalid_attributes}, session: valid_session
        expect(response.status).to be unprocessable_entity
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested employee" do
      employee = Employee.create! valid_attributes
      expect {
        delete :destroy, params: {id: employee.to_param}, session: valid_session
      }.to change(Employee, :count).by(-1)
    end
  end
end
