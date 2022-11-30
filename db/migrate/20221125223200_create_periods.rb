class CreatePeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :periods do |t|
      t.integer :ordinal
      t.integer :year
      t.integer :modality

      t.timestamps
    end
  end
end
