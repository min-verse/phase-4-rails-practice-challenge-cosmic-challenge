class Mission < ApplicationRecord
    belongs_to :scientist
    belongs_to :planet

    validates :name, presence: true
    validates :scientist, presence: true, uniqueness: { scope: :id }
    validates :planet, presence: true
end
