class EmployerPost < ApplicationRecord
    belongs_to :customer
    has_one :insight
    has_one :job_location
    #accepts_nested_attributes_for :insight
    #scope :eposts, -> (customer_id) { where(customer_id: customer_id) }
    scope :eposts, lambda { |customer| where(customer_id: customer)}
    scope :most_recent_first, lambda { order("updated_at DESC")}

end
