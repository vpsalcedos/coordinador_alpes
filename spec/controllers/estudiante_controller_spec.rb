require 'spec_helper'

describe EstudianteController do

  describe "GET 'cuposmas8'" do
    it "returns http success" do
      get 'cuposmas8'
      response.should be_success
    end
  end

end
