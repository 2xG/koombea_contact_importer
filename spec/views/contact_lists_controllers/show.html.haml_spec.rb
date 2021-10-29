require 'rails_helper'

RSpec.describe "contact_lists_controllers/show", type: :view do
  before(:each) do
    @contact_lists_controller = assign(:contact_lists_controller, ContactListsController.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
