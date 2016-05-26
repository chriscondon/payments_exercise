class Payment < ActiveRecord::Base
  belongs_to :loan
  
  after_create :update_outstanding_balance
  before_destroy :restore_outstanding_balance


  
  protected 

  def update_outstanding_balance
    self.loan.outstanding_balance -= self.amount
    self.loan.save 
  end

  def restore_outstanding_balance
    self.loan.outstanding_balance += self.amount
    self.loan.save
  end
end
