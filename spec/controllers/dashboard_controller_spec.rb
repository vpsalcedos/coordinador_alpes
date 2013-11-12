require 'spec_helper'

describe DashboardController do

  describe "GET 'dashboard'" do
    it "returns http success" do
      get 'dashboard'
      response.should be_success
    end
  end

end
