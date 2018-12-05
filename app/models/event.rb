class Event < ApplicationRecord
  belongs_to :seller
  validates :title, presence: true

end
