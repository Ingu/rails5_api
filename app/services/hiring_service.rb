class HiringService
  def initialize(company)
    @company = company
  end

  def hireEmployee(employee_params)
    if employee_params.has_key?(:id)
      employee = Employee.find(employee_params[:id])
      employee.update(employee_params)
    else
      employee = Employee.new(employee_params)
    end
    if employee.save
      @company.hireEmployee(employee)
      @company.save
    end
    employee
  end

  def fireEmployee(employee)
    @company.fireEmployee(employee)
  end
end