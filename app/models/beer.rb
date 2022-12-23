class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating
        x = 0
        ratings.each do |rating|
            x += rating.score
        end
    result = x/ratings.count.to_f
    return result.truncate(2)
    end
end
