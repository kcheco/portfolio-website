require 'rails_helper'

RSpec.describe Image, type: :model do

  it { should validate_presence_of :source }

  it { should belong_to(:coverable) }

  it { should allow_values("https://images-na.ssl-images-amazon.com/images/I/51MoTaVrS7L._SX383_BO1,204,203,200_.jpg").for(:source) }

end
