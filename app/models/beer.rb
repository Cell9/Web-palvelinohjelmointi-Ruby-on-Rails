class Beer < ApplicationRecord
    belongs_to :brewery
    has_many :ratings

    def average_rating

    result = ratings.reduce(0) { |sum, rating| sum + rating.score } / ratings.count.to_f
    return result.truncate(2)
    end

    def to_s
        "#{name},  #{brewery.name}"
     end
end


#inspiration from https://medium.com/@james.a.hughes/using-the-reduce-method-in-ruby-907f3c18ae1f