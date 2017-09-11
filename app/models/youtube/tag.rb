class Youtube::Tag < ApplicationRecord
    validates_uniqueness_of :title
end
