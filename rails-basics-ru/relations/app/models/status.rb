# frozen_string_literal: true

class Status < ApplicationRecord
  # BEGIN
  validates :name, presence: true

  has_many :tasks
  # END
end
