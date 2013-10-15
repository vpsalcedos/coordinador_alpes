require 'spec_helper'

describe Materia do
    let(:materia) { FactoryGirl.create :materia }
  subject { materia }

  # ============
  # Test for valid model
  # ============
  it { should respond_to(:nombre) }
  it { should respond_to(:codigo) }
  it { should respond_to(:tipo) }
  it { should respond_to(:programa) }
  it { should respond_to(:creditos) }

  it { should be_valid }

  # ============
  # Test for attribute presence
  # ============
  describe 'nombre should be present' do
    before { materia.nombre = '' }
    it { should_not be_valid }
  end

  describe 'codigo should be present' do
    before { materia.codigo = '' }
    it { should_not be_valid }
  end

  describe 'tipo should be present' do
    before { materia.tipo = '' }
    it { should_not be_valid }
  end

  describe 'programa should be present' do
    before { materia.programa = '' }
    it { should_not be_valid }
  end

  describe 'creditos should be present' do
    before { creditos.materia_code = nil }
    it { should_not be_valid }
  end
end
