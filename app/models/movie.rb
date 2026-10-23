class Movie < ApplicationRecord
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end

  def self.with_ratings(ratings_list)
    return all if ratings_list.blank?

    ratings = if ratings_list.is_a?(Hash) || ratings_list.is_a?(ActionController::Parameters)
                ratings_list.keys
              else
                Array(ratings_list)
              end

    where('LOWER(rating) IN (?)', ratings.map { |r| r.to_s.downcase })
  end
end
