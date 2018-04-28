class EmployeePost < ApplicationRecord
    belongs_to :customer
    
    scope :recent_requests_first, -> {order("employee_posts.updated_at DESC")}
    
end
