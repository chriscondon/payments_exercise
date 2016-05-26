class PaymentsController < ApplicationController



  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: 'not_found', status: :not_found
  end

  def index
    render json: Payment.all
  end

  def show
    render json: Payment.find(params[:id])
  end

  def create
    return render json: 'error_loan_id_missing', status: :bad_request if params[:loan_id].nil?
    return render json: 'error_payment_amount_missing', status: :bad_request if params[:amount].nil?
    return render json: 'error_payment_date_missing', status: :bad_request if params[:payment_date].nil?
    
    loan = Loan.find(params[:loan_id])
    return render json: 'error_payment_exceeds_funded_amount', status: :bad_request if loan.funded_amount <  BigDecimal(params[:amount])

    payment = Payment.create(payment_params)
    if payment.save
      render json: payment
    else
      render json: 'error_saving_payment', status: :bad_request
    end
  end



  protected

  def payment_params
    params.permit(:loan_id, :amount, :payment_date)
  end
end
