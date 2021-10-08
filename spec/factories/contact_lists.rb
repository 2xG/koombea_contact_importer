FactoryBot.define do
  factory :contact_list do
    csv do
      data = CSV.generate(headers: FactoryBot.attributes_for(:contact).keys) do |csv|
        attributes_for_list(:contact, 10, imported: nil).each { |attrs| csv << attrs }
      end
      file = Tempfile.new
      file << data
      file.close
      Rack::Test::UploadedFile.new(file.path, 'text/csv')
    end

    user { User.all.sample }
  end
end