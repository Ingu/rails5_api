class Company < ApplicationRecord
  belongs_to :ceo, foreign_key: 'ceo_id', optional: true, :class_name => 'Employee', autosave: true, counter_cache: true
  has_and_belongs_to_many :employees
  validates :name, presence: true
  before_save :hireCeo

  def hireCeo
    hireEmployee(ceo) if ceo.present?
  end

  def fireEmployee(employee)
    return unless employee.present?
    self.ceo = nil if self.ceo.eql?(employee)
    self.employees.delete(employee)
    self.save
  end

  def hireEmployee(employee)
    return unless employee.present?
    self.employees << employee unless employees.include?(employee)
    self.save
  end
end