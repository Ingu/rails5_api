require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Company. As you add validations to Company, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {
    name: 'Company Name',
    sector: 'Foo sector',
    industry: 'Bar industry'
  } }

  let(:invalid_attributes) { {
    'sector' => 'Foo sector'
  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CompaniesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all companies as @companies" do
      company = Company.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:companies)).to eq([company])
    end
  end

  describe "GET #show" do
    it "assigns the requested company as @company" do
      company = Company.create! valid_attributes
      get :show, params: {id: company.to_param}, session: valid_session
      expect(assigns(:company)).to eq(company)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Company" do
        expect {
          post :create, params: {company: valid_attributes}, session: valid_session
        }.to change(Company, :count).by(1)
        expect(assigns(:company).name).to eq 'Company Name'
      end

      it "assigns a newly created company as @company" do
        post :create, params: {company: valid_attributes}, session: valid_session
        expect(assigns(:company)).to be_a(Company)
        expect(assigns(:company)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved company as @company" do
        post :create, params: {company: invalid_attributes}, session: valid_session
        expect(assigns(:company)).to be_a_new(Company)
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {
        'name' => 'new name'
      } }

      it "updates the requested company" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, company: new_attributes}, session: valid_session
        company.reload
        expect(company.name).to eq('new name')
      end

      it "assigns the requested company as @company" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, company: valid_attributes}, session: valid_session
        expect(assigns(:company)).to eq(company)
      end
    end

    context "with invalid params" do
      it "assigns the company as @company" do
        company = Company.create! valid_attributes
        put :update, params: {id: company.to_param, company: invalid_attributes}, session: valid_session
        expect(assigns(:company)).to eq(company)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested company" do
      company = Company.create! valid_attributes
      expect {
        delete :destroy, params: {id: company.to_param}, session: valid_session
      }.to change(Company, :count).by(-1)
    end
  end
end