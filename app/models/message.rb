class Message < ApplicationRecord
    include AASM
    
    #belongs_to :sender, class_name: 'Customer', foreign_key: 'sender'
    belongs_to :conversation
    belongs_to :customer
    #belongs_to :discussion
    
    validates_presence_of :msg, :sender_name, :customer_id
    
   aasm column: "status" do
    state :unread, initial: true
    state :read
    state :deleted
    state :rejected

    event :read do
     transitions from: [:unread], to: :read
    end
    event :reject do
     transitions from: [:unread], to: :rejected
    end
    event :delete do
      transitions from: [:read], to: :deleted
    end
    event :mark_as_unread do
      transitions from: [:read], to :unread
    end
   end
    
end
