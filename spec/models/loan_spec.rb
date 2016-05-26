require 'rails_helper'

RSpec.describe Loan, type: :model do

  describe '.outstanding_balance' do
    let(:loan) { Loan.create!(funded_amount: 100.0) }

    context 'if the loan has no payments' do
      it 'is equal to funded_amount' do
        expect(loan.outstanding_balance).to eq(100.0)
      end
    end

    context 'if the loan has 1 payment' do
      it 'is equal to funded_amount minus payment amount' do
        loan.payments.create!(amount: 10.0, payment_date: "2016-05-26 01:01:01" )
        expect(loan.outstanding_balance).to eq(90.0)
      end
    end

    context 'if the loan has multiple payments' do
      it 'is equal to funded_amount minus all payment amounts' do
        loan.payments.create!(amount: 10.0, payment_date: "2016-05-26 01:01:01" )
        loan.payments.create!(amount: 15.0, payment_date: "2016-05-26 02:02:02" )
        expect(loan.outstanding_balance).to eq(75.0)
      end
    end
  end

end