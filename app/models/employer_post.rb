class EmployerPost < ApplicationRecord
    belongs_to :customer
    has_one :insight
    has_one :job_location
    
    accepts_nested_attributes_for :job_location
    #scope :eposts, -> (customer_id) { where(customer_id: customer_id) }
    scope :eposts, lambda { |customer| where(customer_id: customer)}
    scope :most_recent_first, lambda { order("updated_at DESC")}
    
    def check_location?
        unless EmployerPost.job_location
        create_location(self.customer.address,self.customer.city,self.customer.state)
        end
    end    
    def create_location(address,city,state)
        JobLocation.create(location: address, city: city, state: state)
    end
end
