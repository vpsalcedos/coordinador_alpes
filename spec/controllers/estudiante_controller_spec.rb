require 'spec_helper'

describe EstudianteController do

  describe "GET 'creditosfaltantes'" do
    it "returns http success" do
      get 'creditosfaltantes'
      response.should be_success
    end
  end

end
