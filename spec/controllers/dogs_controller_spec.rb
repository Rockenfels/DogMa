require 'rails_helper'
RSpec.describe DogsController, type: :controller do
  before do
      @owner = Owner.create(name: 'Ray O', password:'foo', password_confirmation: 'foo', location: 'co', about_me: 'I love dogs!')
      @shelter = Shelter.new(name: 'Haven to Home', password:'dogs', passowrd_confitmation: 'dogs', location: 'PA', about_us: 'We do too!')
      @dog = Dog.create(
        name: 'Scout',
        breed:'Australian Shepherd',
        age: '7',
        gender: 'Female',
        hometown: 'Ojai, CA',
        description: 'She loves to chase anything that moves and will be your best friend if you throw her a frisbee',
      )
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe 'GET new' do
    it 'checks to see if an owner is logged in' do
      get :new,
        params {name: 'danger dog', breed: 'vicious&malicious', age: 'old'},
        session {owner_id: nil, session_id: nil}
      expect(response).to redirect_to(index_path)
    end

    it 'checks to see if a shelter is logged in' do
      get :new,
        params {name: 'danger dog', breed: 'vicious&malicious', age: 'old'},
        session {owner_id: nil, session_id: nil}
      expect(response).to redirect_to(index_path)
    end
  end

  describe 'POST create' do
    it 'creates a new dog associated to an owner' do
      owned = @dog.merge(owner: @owner)

      expect(owned.owner.id).to eq(@owner.id)
    end

    it 'creates a new dog associated to a shelter' do
      sheltered = @dog.merge(shelter: @shelter)
      expect(sheltered.owner.id).to eq(@owner.id)
    end

    it 'assigns an owner if provided' do
      post :create, params: {name: 'fido', breed: 'lab', age: '3', owner: @owner}
      expect(:dog.owner.id).to eq(@owner.id)
    end

    it 'redirects to login options page if not logged in' do
      post dogs_path,
        params: {name: 'fido', breed: 'lab', age: '3'},
        session: {owner_id: nil, shelter_id: nil}
      expect(response).to redirect_to login_path
    end

    it 'validates owner when nested route' do
      post dogs_path, nil, session: {owner_id: 9999}
      expect(response).to redirect_to index_path
    end

    it 'validates shelter when nested route' do
      post dogs_path, nil, session: {shelter_id: 9999}
      expect(response).to redirect_to index_path
    end
  end

  describe 'GET dogs' do
    it 'returns a page containing a list of dogs from the site' do
      get dogs_path
      expect(page).have_link(@dog.name, dog_path(@dog))
    end
  end
end
