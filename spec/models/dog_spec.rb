require 'pry'
require 'rails_helper'
RSpec.describe Dog, type: :model do
  before(:all) do
    @owner = Owner.create(name: 'Ray O', password:'foo', password_confirmation: 'foo', location: 'co', about_me: 'I love dogs!')
    @dog = Dog.create(name: 'Ripton', breed: 'Hound/Lab', age:'6', gender: 'Male', description:'He likes 3 things: trash, scents, and snuggles', hometown: 'Colorado Springs, CO')
    @owner.dogs << @dog
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  it 'has a name field' do
    expect(@dog.name).to eq('Ripton')
  end

  it 'has a breed field' do
    expect(@dog.breed).to eq('Hound/Lab')
  end

  it 'has an age field' do
    expect(@dog.age).to eq('6')
  end

  it 'has a gender field' do
    expect(@dog.gender).to eq('Male')
  end

  it 'has a description field' do
    expect(@dog.description).to eq('He likes 3 things: trash, scents, and snuggles')
  end

#ADD A VIRTUAL TO DOG CLASS FOR OWNER_NAME
  it 'has an owner field' do
    expect(@dog.owner.id).to eq(@owner.id)
  end

#ADD A VIRTUAL TO DOG CLASS FOR SHELTER_NAME
  it 'has a shelter field' do
    expect(@dog).to respond_to(:shelter_id)
  end

  it 'has a hometown field' do
    expect(@dog.hometown).to eq('Colorado Springs, CO')
  end

end
