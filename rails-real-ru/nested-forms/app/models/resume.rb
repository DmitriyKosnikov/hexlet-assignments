# frozen_string_literal: true

class Resume < ApplicationRecord
  validates :name, presence: true
  validates :contact, presence: true

  # BEGIN
  has_many :works, class_name: 'ResumeWork', dependent: :destroy
  has_many :educations, class_name: 'ResumeEducation', dependent: :destroy

  accepts_nested_attributes_for :works
  accepts_nested_attributes_for :educations
  # END
end
