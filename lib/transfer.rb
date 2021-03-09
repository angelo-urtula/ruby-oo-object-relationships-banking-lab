class Transfer

  attr_accessor :status
  attr_reader :sender, :receiver, :amount
  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid?
    @receiver.valid?
  end

  def execute_transaction
    if self.valid? && @sender.balance > @amount
      until @status == "complete" do
        @sender.balance -= @amount
        @receiver.deposit(@amount)
        @status = "complete"
      end
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == "complete"
      until @status == "reversed" do
      @sender.deposit(@amount)
      @receiver.balance -= @amount
      @status = "reversed"
      end
    end
  end
end
