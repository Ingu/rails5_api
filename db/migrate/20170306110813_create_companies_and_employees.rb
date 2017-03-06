class CreateCompaniesAndEmployees < ActiveRecord::Migration[5.0]
  def change
    create_table :employees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :social_number
      t.timestamps
    end

    create_table :companies do |t|
      t.string :name, unique: true, null: false
      t.integer :ceo_id
      t.string :sector
      t.string :industry
      t.timestamps
    end

    create_join_table :companies, :employees
    add_foreign_key :companies, :employees, column: :ceo_id

  end
end
