require 'spec_helper'

describe MateriaController do

  describe "GET 'detalles'" do
    it "returns http success" do
      get 'detalles'
      response.should be_success
    end
  end

end
