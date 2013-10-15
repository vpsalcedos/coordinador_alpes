require 'spec_helper'

describe Planeacion do
   let(:planeacion) { FactoryGirl.create :planeacion }
  subject { planeacion }

  # ============
  # Test for valid model
  # ============
  it { should respond_to(:codigoMateria) }
  it { should respond_to(:cupos) }
  it { should respond_to(:semestre) }

  it { should be_valid }
end
