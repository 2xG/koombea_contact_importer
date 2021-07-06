# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts.imported
  end

  def import

  end
end
