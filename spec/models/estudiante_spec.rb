require 'spec_helper'

describe Estudiante do
   let(:estudiante) { FactoryGirl.create :estudiante }
  subject { estudiante }

  # ============
  # Test for valid model
  # ============
  it { should respond_to(:nombre) }
  it { should respond_to(:codigo) }
  it { should respond_to(:apellido) }
  it { should respond_to(:programa) }
  it { should be_valid }

  # ============
  # Test for attribute presence
  # ============
  describe 'nombre should be present' do
    before { estudiante.nombre = '' }
    it { should_not be_valid }
  end

  describe 'codigo should be present' do
    before { estudiante.codigo = '' }
    it { should_not be_valid }
  end

  describe 'apellido should be present' do
    before { estudiante.apellido = '' }
    it { should_not be_valid }
  end

  describe 'programa should be present' do
    before { estudiante.programa = '' }
    it { should_not be_valid }
  end

  # ============
  # Test for name validation
  # ============
  describe 'nombre should have valid length' do
    before { estudiante.nombre = 'a' * 201 }
    it { should_not be_valid }
  end

end
