require 'spec_helper'

describe Carpeta do
  let(:carpeta) { FactoryGirl.create :carpeta }
  subject { carpeta }

  it { should respond_to(:idEstudiante) }
  it { should respond_to(:tipoMateria) }
  it { should respond_to(:creditos) }
  it { should respond_to(:codigoMateria) }

  it { should be_valid }


end
