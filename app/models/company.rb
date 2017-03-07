class Company < ApplicationRecord
  belongs_to :ceo, foreign_key: 'ceo_id', optional: true, :class_name => 'Employee'
  has_and_belongs_to_many :employees
  validates :name, presence: true

  def fireEmployee(employee)
    return unless employee.present?
    self.ceo = nil if self.ceo.eql?(employee)
    self.employees.delete(employee)
    self.save
  end

  def hireEmployee(employee)
    return unless employee.present?
    self.employees << employee
    self.save
  end
end