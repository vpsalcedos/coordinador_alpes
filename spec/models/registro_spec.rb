require 'spec_helper'

describe Registro do
    let(:registro) { FactoryGirl.create :registro}
  subject { registro }

  # ============
  # Test for valid model
  # ============
  it { should respond_to(:idEstudiante) }
  it { should respond_to(:idPlaneacion) }
  it { should respond_to(:prioridad) }

  it { should be_valid }
end
