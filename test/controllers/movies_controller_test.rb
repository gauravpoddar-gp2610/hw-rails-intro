require "test_helper"

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
  end

  test "should get index" do
    get movies_url
    assert_response :success
  end

  test "should filter movies by rating" do
    get movies_url, params: { ratings: { "G" => "1" } }
    assert_response :success
  end

  test "should sort movies by title" do
    get movies_url, params: { sort_by: "title" }
    assert_response :success
  end

  test "should remember session settings and redirect when navigating back without params" do
    # First request sets session
    get movies_url, params: { ratings: { "G" => "1" }, sort_by: "title" }
    assert_response :success

    # Second request with no params redirects to preserved RESTful URL
    get movies_url
    assert_response :redirect
    assert_redirected_to movies_path(sort_by: "title", ratings: { "G" => "1" })
  end

  test "should reset to all ratings when refresh clicked with no checkboxes" do
    get movies_url, params: { commit: "Refresh" }
    assert_response :success
  end

  test "should get new" do
    get new_movie_url
    assert_response :success
  end

  test "should create movie" do
    assert_difference("Movie.count") do
      post movies_url, params: { movie: { description: @movie.description, rating: @movie.rating, release_date: @movie.release_date, title: @movie.title } }
    end

    assert_redirected_to movie_url(Movie.last)
  end

  test "should show movie" do
    get movie_url(@movie)
    assert_response :success
  end

  test "should get edit" do
    get edit_movie_url(@movie)
    assert_response :success
  end

  test "should update movie" do
    patch movie_url(@movie), params: { movie: { description: @movie.description, rating: @movie.rating, release_date: @movie.release_date, title: @movie.title } }
    assert_redirected_to movie_url(@movie)
  end

  test "should destroy movie" do
    assert_difference("Movie.count", -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
end
