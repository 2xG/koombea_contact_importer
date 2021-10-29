require 'rails_helper'

RSpec.describe "contact_lists_controllers/new", type: :view do
  before(:each) do
    assign(:contact_lists_controller, ContactListsController.new())
  end

  it "renders new contact_lists_controller form" do
    render

    assert_select "form[action=?][method=?]", contact_lists_controllers_path, "post" do
    end
  end
end
