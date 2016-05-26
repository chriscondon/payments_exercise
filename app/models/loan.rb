class Loan < ActiveRecord::Base
  has_many :payments, dependent: :destroy
  after_create :initialize_outstanding_balance


  protected

  def initialize_outstanding_balance
    self.outstanding_balance = self.funded_amount
    self.save
  end
end
