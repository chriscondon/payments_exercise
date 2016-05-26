require 'rails_helper'

RSpec.describe LoansController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'responds with a 200' do
      get :show, id: loan.id
      expect(response).to have_http_status(:ok)
    end

    it 'responds with correct funded_amount' do
      get :show, id: loan.id
      json_response = JSON.parse(response.body)
      expect(json_response['funded_amount']).to eql("100.0")
    end

    it 'responds with outstanding_balance equal to funded_amount' do
      get :show, id: loan.id
      json_response = JSON.parse(response.body)
      expect(json_response['outstanding_balance']).to eql("100.0")
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#payments' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    
    it 'displays payments for a given loan' do 
      Payment.create!(loan: loan, amount: 11.5, payment_date: "2016-05-26 01:01:01")
      get :payments, id: loan.id
      json_response = JSON.parse(response.body)
      expect(json_response[0]['amount']).to eql("11.5")
    end
  end
end
