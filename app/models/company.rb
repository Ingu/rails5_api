class Company < ApplicationRecord
  belongs_to :employee, foreign_key: 'ceo_id', optional: true
  has_and_belongs_to_many :employees
  validates :name, presence: true

  def ceo
    if self.ceo_id.present?
      Employee.find(self.ceo_id)
    end
  end

  def ceo=(employee)
    if employee.is_a?(Employee)
      self.ceo_id = employee.id
    else
      # raise
    end
  end
end