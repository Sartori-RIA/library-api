require 'rails_helper'

RSpec.describe "dashboards/edit", type: :view do
  let(:dashboard) {
    Dashboard.create!(
      index: "MyString"
    )
  }

  before(:each) do
    assign(:dashboard, dashboard)
  end

  it "renders the edit dashboard form" do
    render

    assert_select "form[action=?][method=?]", dashboard_path(dashboard), "post" do

      assert_select "input[name=?]", "dashboard[index]"
    end
  end
end
