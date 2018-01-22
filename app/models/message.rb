class Message < ApplicationRecord
    
    #belongs_to :sender, class_name: 'Customer', foreign_key: 'sender'
    belongs_to :conversation
    belongs_to :customer
    
    validates_presence_of :msg, :conversation_id, :customer_id
    
end
