require 'rails_helper'

RSpec.describe Image, type: :model do

  it { should validate_presence_of :source }

  it { should belong_to(:coverable).optional }

  it { should allow_values("https://images-na.ssl-images-amazon.com/images/I/51MoTaVrS7L._SX383_BO1,204,203,200_.jpg").for(:source) }

  it { should_not allow_values("http://image.example.com/no-image-path/",
                               "http://image.example.com/no-image-path/pdf_file.pdf",
                               "http://image.example.com/no-image-path/word_file.docx").for(:source) }

end
