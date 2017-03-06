class Employee < ApplicationRecord
  has_and_belongs_to_many :companies
  attr_readonly :companies

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :social_number, length: {is: 9}
end