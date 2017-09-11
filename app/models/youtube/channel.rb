class Youtube::Channel < ApplicationRecord
    validates_uniqueness_of :uid
    
end
