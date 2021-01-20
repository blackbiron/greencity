class City < ApplicationRecord
  # plugins
  extend FriendlyId
  friendly_id :name, use: :slugged

  # associations
  belongs_to :country
end
