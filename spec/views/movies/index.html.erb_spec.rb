require 'spec_helper'

describe "movies/index" do
  before(:each) do
    assign(:movies, [
      stub_model(Movie,
        :imdb_id => "Imdb",
        :title => "Title",
        :tagline => "Tagline",
        :plot => "Plot",
        :runtime => 1,
        :rating => 1.5,
        :votes => 2,
        :poster_url => "Poster Url"
      ),
      stub_model(Movie,
        :imdb_id => "Imdb",
        :title => "Title",
        :tagline => "Tagline",
        :plot => "Plot",
        :runtime => 1,
        :rating => 1.5,
        :votes => 2,
        :poster_url => "Poster Url"
      )
    ])
  end

  it "renders a list of movies" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Imdb".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Tagline".to_s, :count => 2
    assert_select "tr>td", :text => "Plot".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Poster Url".to_s, :count => 2
  end
end
