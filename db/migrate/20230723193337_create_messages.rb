class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.string :sender
      t.string :receiver

      t.timestamps
    end
  end
end
