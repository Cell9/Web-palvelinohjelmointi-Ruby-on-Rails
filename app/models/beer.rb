class Beer < ApplicationRecord
    include RatingAverage

    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def to_s
        "#{name},  #{brewery.name}"
     end
end


#inspiration from https://medium.com/@james.a.hughes/using-the-reduce-method-in-ruby-907f3c18ae1f