require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  describe '#index' do
    it 'responds with a 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }
    let(:payment) { Payment.create!(loan: loan, amount: 10.0, payment_date: "2016-05-26 01:01:01") }

    it 'responds with a 200' do
      get :show, id: payment.id
      expect(response).to have_http_status(:ok)
    end

    it 'responds with correct loan_id' do
      get :show, id: payment.id
      json_response = JSON.parse(response.body)
      expect(json_response["loan_id"]).to eq(loan.id)
    end

    it 'responds with correct payment amount' do
      get :show, id: payment.id
      json_response = JSON.parse(response.body)
      expect(json_response["amount"]).to eq("10.0")
    end

    it 'responds with correct payment date' do
      get :show, id: payment.id
      json_response = JSON.parse(response.body)
      expect(json_response["payment_date"]).to eq("2016-05-26T01:01:01.000Z")
    end

    context 'if the loan is not found' do
      it 'responds with a 404' do
        get :show, id: 10000
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    it 'POST responds with a 200' do
      post :create, {loan_id: loan.id, amount: 1.0, payment_date: '2016-05-26 01:01:01'}
      expect(response).to have_http_status(:ok)
    end

    context 'with invalid requests' do
      it 'returns validation error if loan_id is missing' do
        post :create, { amount: 1.0, payment_date: '2016-05-26 01:01:01'}
        expect(response.body).to eq('error_loan_id_missing')
      end

      it 'returns validation error if payment amount missing' do
        post :create, {loan_id: loan.id, payment_date: '2016-05-26 01:01:01'}
        expect(response.body).to eq('error_payment_amount_missing')
      end

      it 'returns validation error if payment date missing' do
        post :create, {loan_id: loan.id, amount: 1.0 }
        expect(response.body).to eq('error_payment_date_missing')
      end

      it 'does not allow payment amount to exceed outstanding_balance of parent loan' do
        post :create, {loan_id: loan.id, amount: 9999999.99, payment_date: '2016-05-26 01:01:01'}
        expect(response.body).to eq('error_payment_exceeds_funded_amount')
      end

      it 'ignores invalid payment params' do
        post :create, {unneccessary_id: "XYZ", loan_id: loan.id, amount: 1.0, payment_date: '2016-05-26 01:01:01'}
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
