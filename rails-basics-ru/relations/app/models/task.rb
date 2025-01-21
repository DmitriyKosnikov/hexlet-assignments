class Task < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true

  belongs_to :status
  belongs_to :user
end
