class TestController < ApplicationController

  def new

    @hallo = "Hallo mod250"
    @random = User.first.name.reverse
  end

end
