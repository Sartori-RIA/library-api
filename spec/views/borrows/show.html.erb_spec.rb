require 'rails_helper'

RSpec.describe "borrows/show", type: :view do
  before(:each) do
    assign(:borrow, Borrow.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
