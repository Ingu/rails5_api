class CompanyEmployeesController < ApplicationController
  before_action :set_company
  before_action :set_employee, only: [:show, :update, :destroy]

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
    employee = Employee.new(employee_params)
    if employee.save
      @company.hireEmployee(employee)
      if @company.save
        render json: employee, status: :created, location: @company
      else
        render json: @company.errors, status: :unprocessable_entity
      end
    else
      render json: employee.errors, status: :unprocessable_entity
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
    @company.fireEmployee(@employee)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_company
    @company = Company.find(params[:company_id])
  end

  def set_employee
    @employee = @company.employees.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :social_number, :id)
  end
end
