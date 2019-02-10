class Skill < ApplicationRecord
  # validation rules
  validates_presence_of   :name

  # methods
  def name_in_dash_case
    name.gsub(/\s/, '-').downcase
  end
end
