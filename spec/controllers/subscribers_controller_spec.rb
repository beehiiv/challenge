require 'rails_helper'

RSpec.describe SubscribersController, type: :controller do
  describe 'GET #index' do
    let!(:subscribers) { create_list(:subscriber, 3) }

    it 'returns a list of subscribers' do
      allow(Subscriber).to receive(:count).and_return(subscribers.size)

      get :index, format: :json
      
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['subscribers'].size).to eq(3)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { name: 'John Doe', email: 'johndoe@example.com' } }

    context 'with valid attributes' do
      it 'creates a new subscriber' do
        expect {
          post :create, params: valid_attributes, format: :json
        }.to change(Subscriber, :count).by(1)
      end

      it 'returns a success message' do
        post :create, params: valid_attributes, format: :json
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Subscriber created successfully')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { name: '', email: 'invalid_email' } }

      it 'does not create a new subscriber' do
        expect {
          post :create, params: invalid_attributes, format: :json
        }.not_to change(Subscriber, :count)
      end
    end
  end

  describe 'PUT #update' do
    let(:subscriber) { create(:subscriber) }

    context 'with valid attributes' do
      let(:valid_attributes) { { id: subscriber.id, status: 'new_status' } }

      it 'updates the subscriber' do
        put :update, params: valid_attributes, format: :json
        expect(subscriber.reload.status).to eq('new_status')
      end

      it 'returns a success message' do
        put :update, params: valid_attributes, format: :json
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Subscriber updated successfully')
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { id: subscriber.id, status: '' } }

      it 'does not update the subscriber' do
        initial_status = subscriber.status
        put :update, params: invalid_attributes, format: :json
        expect(subscriber.reload.status).to eq(initial_status)
      end
    end
  end
end
