# frozen_string_literal: true

module ContactsHelper

  # @param dob [Date]
  def format_dob(dob)
    dob&.strftime '%Y %B %e'
  end

  def error_list(contact)
    content_tag :ol, class: 'list-group list-group-numbered' do
      contact.error_list.split("\n").map do |error|
        content_tag(:li, error, class: 'list-group-item')
      end.reduce(&:+)
    end
  end
end
