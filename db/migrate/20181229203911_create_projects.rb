class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.datetime :date_completed
      t.string :link

      t.timestamps
    end
  end
end
