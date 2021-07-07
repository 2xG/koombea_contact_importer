class ContactListsController < ApplicationController
  before_action :set_contact_list, only: %i[edit update destroy]

  def index
    @contact_lists = current_user.contact_lists
  end

  def edit
    redirect_to contact_lists_path, notice: "The list is already processed" unless @contact_list.on_hold?
  end

  def create
    @contact_list = current_user.contact_lists.build(contact_list_params)

    if @contact_list.save
      redirect_to edit_contact_list_path(@contact_list) #, notice: "Contact list was successfully updated."
    else
      redirect_to contacts_path, alert: @contact_list.errors.full_messages
    end
  end

  def update
    if @contact_list.update(contact_list_params)
      redirect_to contact_lists_path, notice: "Contact list was successfully mapped"
    else
      render :edit, status: :unprocessable_entity, alert: @contact_list.errors.full_messages
    end
  end

  private

  def set_contact_list
    @contact_list = current_user.contact_lists.find(params[:id])
  end

  def contact_list_params
    params.fetch(:contact_list, {}).permit(:csv, :header_row, mapping: {})
  end
end
