require 'rails_helper'
RSpec.describe DogsController, type: :controller do
  before do
      @owner = Owner.create(name: 'Ray O', password:'foo', password_confirmation: 'foo', location: 'co', about_me: 'I love dogs!')
  end

  after(:all) do
    DatabaseCleaner.clean_with(:truncation)
  end

  describe 'GET new' do
    it 'assigns an owner if provided' do
      get :new, params: {name: 'fido', breed: 'lab', age: '3', owner: @owner}
      expect(:dog.owner.id).to eq(@owner.id)
    end

    it 'redirects to login options page if not logged in' do
      get :new,
        params: {name: 'fido', breed: 'lab', age: '3'},
        session: {owner_id: nil, shelter_id: nil}
      expect(response).to redirect_to login_path
    end

    it 'validates owner when nested route' do
      get :new, nil, session: {owner_id: 9999}
      expect(response).to redirect_to index_path
    end

    it 'validates shelter when nested route' do
      get :new, nil, session: {shelter_id: 9999}
      expect(response).to redirect_to index_path
    end
  end
end
