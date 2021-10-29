require 'rails_helper'

RSpec.describe "contact_lists_controllers/edit", type: :view do
  before(:each) do
    @contact_lists_controller = assign(:contact_lists_controller, ContactListsController.create!())
  end

  it "renders the edit contact_lists_controller form" do
    render

    assert_select "form[action=?][method=?]", contact_lists_controller_path(@contact_lists_controller), "post" do
    end
  end
end
