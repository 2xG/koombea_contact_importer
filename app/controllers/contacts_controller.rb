# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    @contacts = current_user.contacts.imported.page(params[:page])
  end

  def errors
    @contacts = current_user.contacts.failed.page(params[:page])
  end
end
