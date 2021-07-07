class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # disabled - :recoverable, :validatable
  devise :database_authenticatable, :registerable, :rememberable

  has_many :contacts
  has_many :contact_lists

  default_scope { order(created_at: :desc) }
end
