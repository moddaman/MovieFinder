require 'spec_helper'

describe "movies/edit" do
  before(:each) do
    @movie = assign(:movie, stub_model(Movie,
      :imdb_id => "MyString",
      :title => "MyString",
      :tagline => "MyString",
      :plot => "MyString",
      :runtime => 1,
      :rating => 1.5,
      :votes => 1,
      :poster_url => "MyString"
    ))
  end

  it "renders the edit movie form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", movie_path(@movie), "post" do
      assert_select "input#movie_imdb_id[name=?]", "movie[imdb_id]"
      assert_select "input#movie_title[name=?]", "movie[title]"
      assert_select "input#movie_tagline[name=?]", "movie[tagline]"
      assert_select "input#movie_plot[name=?]", "movie[plot]"
      assert_select "input#movie_runtime[name=?]", "movie[runtime]"
      assert_select "input#movie_rating[name=?]", "movie[rating]"
      assert_select "input#movie_votes[name=?]", "movie[votes]"
      assert_select "input#movie_poster_url[name=?]", "movie[poster_url]"
    end
  end
end
