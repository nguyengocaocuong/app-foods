class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string
    add_column :users, :address, :string
    add_column :users, :phoneNumber, :string
    add_column :users, :dob, :date
    add_column :users, :age, :integer
  end
end
