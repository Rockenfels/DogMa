require 'rails_helper'

RSpec.describe Shelter, type: :model do
  it 'has a password field' do
    expect(Shelter.new).to respond_to(:password)
  end

  it 'has a name field' do
    expect(Shelter.new).to respond_to(:name)
  end

  it 'has a password confirmation field' do
    expect(Shelter.new).to respond_to(:password_confirmation)
  end

  it 'is valid if password and password_confirmation match' do
    shelter = Shelter.new
    shelter.password = shelter.password_confirmation = 'foo'
    expect(shelter.valid?).to be true
  end

  it 'is valid if password is set and password_confirmation is nil' do
     shelter = Shelter.new
     shelter.password = 'foo'
     expect(shelter.valid?).to be true
  end

  it "is invalid if password and password_confirmation are both non-nil and don't match" do
    shelter = Shelter.new
    shelter.password = 'foo'
    shelter.password_confirmation = 'fo0'
    expect(shelter.valid?).to be false
  end

  describe 'authenticate' do
    it 'returns the shelter if credentials match' do
      shelter = Shelter.new
      shelter.password = 'foo'
      expect(shelter.authenticate('foo')).to eq(shelter)
    end

    it "returns falsey if credentials don't match" do
      shelter = Shelter.new
      shelter.password = 'foo'
      expect(shelter.authenticate('fo0')).to be_falsey
    end
  end
end
