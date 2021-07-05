# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/contacts', type: :request do
  # Contact. As you add validations to Contact, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Contact.create! valid_attributes
      get contacts_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      contact = Contact.create! valid_attributes
      get contact_url(contact)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_contact_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      contact = Contact.create! valid_attributes
      get edit_contact_url(contact)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Contact' do
        expect do
          post contacts_url, params: { contact: valid_attributes }
        end.to change(Contact, :count).by(1)
      end

      it 'redirects to the created contact' do
        post contacts_url, params: { contact: valid_attributes }
        expect(response).to redirect_to(contact_url(Contact.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Contact' do
        expect do
          post contacts_url, params: { contact: invalid_attributes }
        end.to change(Contact, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post contacts_url, params: { contact: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested contact' do
        contact = Contact.create! valid_attributes
        patch contact_url(contact), params: { contact: new_attributes }
        contact.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the contact' do
        contact = Contact.create! valid_attributes
        patch contact_url(contact), params: { contact: new_attributes }
        contact.reload
        expect(response).to redirect_to(contact_url(contact))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        contact = Contact.create! valid_attributes
        patch contact_url(contact), params: { contact: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested contact' do
      contact = Contact.create! valid_attributes
      expect do
        delete contact_url(contact)
      end.to change(Contact, :count).by(-1)
    end

    it 'redirects to the contacts list' do
      contact = Contact.create! valid_attributes
      delete contact_url(contact)
      expect(response).to redirect_to(contacts_url)
    end
  end
end
