require 'rails_helper'

RSpec.describe "contact_lists_controllers/index", type: :view do
  before(:each) do
    assign(:contact_lists_controllers, [
      ContactListsController.create!(),
      ContactListsController.create!()
    ])
  end

  it "renders a list of contact_lists_controllers" do
    render
  end
end
