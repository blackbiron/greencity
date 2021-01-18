# frozen_string_literal: true

class Country < ApplicationRecord
  # plugins
  acts_as_paranoid
  extend FriendlyId
  friendly_id :name, use: :slugged

  # associations
  has_many :cities, dependent: :destroy
end
