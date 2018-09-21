class CreatePhoneNumbers < ActiveRecord::Migration[5.1]
  def change
    create_table :phone_numbers do |t|

      t.string :number

      # t.timestamps
    end
    add_index :phone_numbers, :number, unique: true
  end
end
