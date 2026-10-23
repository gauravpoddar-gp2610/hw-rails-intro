require "test_helper"

class MovieTest < ActiveSupport::TestCase
  test "all_ratings returns list of MPAA ratings" do
    assert_equal ['G', 'PG', 'PG-13', 'R'], Movie.all_ratings
  end

  test "with_ratings filters correctly by rating list" do
    g_movies = Movie.with_ratings(['G'])
    assert g_movies.all? { |m| m.rating == 'G' }
    assert g_movies.any? { |m| m.title == 'Aladdin' }
  end

  test "with_ratings is case insensitive" do
    r_movies = Movie.with_ratings(['r'])
    assert r_movies.any? { |m| m.title == 'The Terminator' }
  end

  test "with_ratings returns all movies when ratings_list is nil or empty" do
    assert_equal Movie.count, Movie.with_ratings(nil).count
    assert_equal Movie.count, Movie.with_ratings([]).count
  end
end
