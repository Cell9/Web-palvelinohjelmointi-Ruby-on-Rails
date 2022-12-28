module RatingAverage
    extend ActiveSupport::Concern

    def average_rating
      result = ratings.reduce(0) { |sum, rating| sum + rating.score } / ratings.count.to_f
      return result.truncate(2)
    end

end