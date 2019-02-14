class AddOrdernoToSkills < ActiveRecord::Migration[5.1]
  def change
    add_column :skills, :orderno, :integer
  end
end
