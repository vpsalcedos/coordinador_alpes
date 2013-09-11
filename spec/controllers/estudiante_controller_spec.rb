require 'spec_helper'

describe EstudianteController do

  describe "GET 'buscarEstudiantesMasOcho'" do
    it "returns http success" do
      get 'buscarEstudiantesMasOcho'
      response.should be_success
    end
  end

end
