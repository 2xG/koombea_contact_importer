# frozen_string_literal: true

module ContactsHelper

  # @param dob [Date]
  def format_dob(dob)
    dob&.strftime '%Y %B %e'
  end
end
