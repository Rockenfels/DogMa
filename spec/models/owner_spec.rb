require 'rails_helper'

RSpec.describe Owner, type: :model do
  it 'has a password field' do
    expect(Owner.new).to respond_to(:password)
  end

  it 'has a name field' do
    expect(Owner.new).to respond_to(:name)
  end

  it 'has a password confirmation field' do
    expect(Owner.new).to respond_to(:password_confirmation)
  end

  it 'is valid if password and password_confirmation match' do
    owner = Owner.new
    owner.password = owner.password_confirmation = 'foo'
    expect(owner.valid?).to be true
  end

  it 'is valid if password is set and password_confirmation is nil' do
     owner = Owner.new
     owner.password = 'foo'
     expect(owner.valid?).to be true
  end

  it "is invalid if password and password_confirmation are both non-nil and don't match" do
    owner = Owner.new
    owner.password = 'foo'
    owner.password_confirmation = 'fo0'
    expect(owner.valid?).to be false
  end

it 'has a location and an about me field' do
  owner = Owner.new
  expect(owner).to respond_to(:location, :about_me)
end

  describe 'authenticate' do
    it 'returns the owner if credentials match' do
      owner = Owner.new
      owner.password = 'foo'
      expect(owner.authenticate('foo')).to eq(owner)
    end

    it "returns falsey if credentials don't match" do
      owner = Owner.new
      owner.password = 'foo'
      expect(owner.authenticate('fo0')).to be_falsey
    end
  end
end
