require "rails_helper"

RSpec.describe ContactListsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/contact_lists_controllers").to route_to("contact_lists_controllers#index")
    end

    it "routes to #new" do
      expect(get: "/contact_lists_controllers/new").to route_to("contact_lists_controllers#new")
    end

    it "routes to #show" do
      expect(get: "/contact_lists_controllers/1").to route_to("contact_lists_controllers#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/contact_lists_controllers/1/edit").to route_to("contact_lists_controllers#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/contact_lists_controllers").to route_to("contact_lists_controllers#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/contact_lists_controllers/1").to route_to("contact_lists_controllers#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/contact_lists_controllers/1").to route_to("contact_lists_controllers#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/contact_lists_controllers/1").to route_to("contact_lists_controllers#destroy", id: "1")
    end
  end
end