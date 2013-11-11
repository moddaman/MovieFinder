require 'spec_helper'

describe "movies/show" do
  before(:each) do
    @movie = assign(:movie, stub_model(Movie,
      :imdb_id => "Imdb",
      :title => "Title",
      :tagline => "Tagline",
      :plot => "Plot",
      :runtime => 1,
      :rating => 1.5,
      :votes => 2,
      :poster_url => "Poster Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Imdb/)
    rendered.should match(/Title/)
    rendered.should match(/Tagline/)
    rendered.should match(/Plot/)
    rendered.should match(/1/)
    rendered.should match(/1.5/)
    rendered.should match(/2/)
    rendered.should match(/Poster Url/)
  end
end
