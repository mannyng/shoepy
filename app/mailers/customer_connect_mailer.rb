class CustomerConnectMailer < ApplicationMailer
    default from: "support@kwanga.ml"
    
    def welcome(friend,sent_at=Time.now)
        @friend = friend
        @sent_at = sent_at
        @greeting = "Welcome"
        
        delivery_options = { user_name: "SMTP_KEY",
                           password: "SMPT_PASS",
                           address: "mail.kwanga.ml" }
        mail(
            subject: "Welcome to Kwangs",
            to: @friend.user.email,
            delivery_method_options: delivery_options
            ) 
    end 
    def friend_request_accepted(customer,sent_at=Time.now)
        @customer = customer
        @sent_at = sent_at
        @greeting = "Thanks"
        
        delivery_options = { user_name: "SMTP_KEY",
                           password: "SMPT_PASS",
                           address: "mail.kwanga.ml" }
        mail(
            subject: "Thanks for connecting",
            to: @customer.user.email,
            delivery_method_options: delivery_options
            ) 
    end 
end
