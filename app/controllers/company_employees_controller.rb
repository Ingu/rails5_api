require_relative '../services/hiring_service'

class CompanyEmployeesController < ApplicationController
  before_action :set_company
  before_action :set_employee, only: [:show, :update, :destroy]
  before_action :set_hiring_service, only: [:create, :destroy]

  # GET /companies/1/employees
  def index
    render json: @company.employees
  end

  # GET /companies/1/employees/1
  def show
    render json: @employee
  end

  # POST /companies/1/employees
  def create
    employee = @hiring_service.hireEmployee(employee_params)
    if employee.errors.present?
      render json: employee.errors, status: :unprocessable_entity
    else
      render json: employee, status: :created, location: @company
    end
  end

  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1/employees/1
  def destroy
    @hiring_service.fireEmployee(@employee)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_employee
    @employee = @company.employees.find(params[:id])
  end

  def set_hiring_service
    @hiring_service = HiringService.new(@company)
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :social_number, :id)
  end
end
