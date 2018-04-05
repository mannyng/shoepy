class Message < ApplicationRecord
    
    #belongs_to :sender, class_name: 'Customer', foreign_key: 'sender'
    belongs_to :conversation
    belongs_to :customer
    #belongs_to :discussion
    
    validates_presence_of :msg, :sender_name, :customer_id
    
end
