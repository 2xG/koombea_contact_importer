require 'rails_helper'
require 'csv'

RSpec.describe ContactListsController, type: :controller do
  context 'GET index' do
    context 'with logged-in user' do
      before { sign_in User.first }

      it 'returns HTTP response 200' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context 'without logged-in user' do
      it 'returns HTTP response 302' do
        get :index
        expect(response).to have_http_status(:found) and
          render_template(:index)
      end
    end
  end

  context 'POST create' do
    before { sign_in User.first }

    context 'with correct data' do
      let(:file_path) { './tmp/test.csv' }
      let(:csv) do
        data = CSV.generate(headers: FactoryBot.attributes_for(:contact).keys) do |csv|
          attributes_for_list(:contact, 10, imported: nil).each { |attrs| csv << attrs }
        end
        File.write(file_path, data)
        fixture_file_upload(file_path, 'text/csv')
      end

      after do
        File.delete(file_path) if File.exist?(file_path)
        ContactList.destroy_all
      end

      it 'creates a list' do
        post(:create, params: { contact_list: { csv: csv } })
        expect(response).to redirect_to edit_contact_list_path(ContactList.last)
      end
    end

    context 'with incorrect data' do
      skip '🤔' # TODO: what could be incorrect data in that case?
    end
  end
end
