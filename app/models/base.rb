class Base < ApplicationRecord
  validates :number, presence: true, uniqueness: true
  validates :name, presence: true, uniqueness: true
end
