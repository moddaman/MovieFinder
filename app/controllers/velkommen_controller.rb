class VelkommenController < ApplicationController

  def hei
    @hallo = "HEI MOD250".reverse
    @random = User.first
  end


end
