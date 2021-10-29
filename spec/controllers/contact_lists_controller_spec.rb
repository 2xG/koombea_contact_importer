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
      let(:csv) do
        data = CSV.generate(headers: FactoryBot.attributes_for(:contact).except(:imported).keys) do |csv|
          attributes_for_list(:contact, 10, imported: nil).each { |attrs| csv << attrs }
        end
        Tempfile.create do |f|
          f << data
          fixture_file_upload(f.path, 'text/csv')
        end
      end

      after do
        ContactList.destroy_all
      end

      it 'creates a list' do
        post(:create, params: { contact_list: { csv: csv } })
        expect(response).to redirect_to edit_contact_list_path(ContactList.last)
      end
    end

    context 'with incorrect data' do
      skip '🤔' # TODO: wrong file type check
    end
  end

  context 'GET edit' do
    render_views

    before { sign_in User.first }
    after { ContactList.destroy_all }

    let(:contact_list) do
      FactoryBot.create(:contact_list)
    end

    it 'shows first 5 rows of csv' do
      get(:edit, params: { id: contact_list.id })
      names = CSV.foreach(ActiveStorage::Blob.service.path_for(contact_list.csv.key), headers: false).take(6)
      expect(response.body).to include(*names.first(5).flatten.map(&:to_s))
      expect(response.body).not_to include(*names.last[3])
    end
  end

  context 'PUT update' do
    context 'with correct mapping' do

    end
    context 'with incorrect mapping' do

    end
  end
end
