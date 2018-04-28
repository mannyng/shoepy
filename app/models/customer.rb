class Customer < ApplicationRecord
    belongs_to :user
    has_many :employer_posts
    has_many :employee_posts
    has_many :insights, through: :employer_posts
    has_many :job_locations, through: :employer_posts
    has_many :customer_connects
    
    has_many :messages
    has_many :conversations, through: :messages  #checking this out
    has_many :friends, through: :customer_connects
    has_many :pending_customer_connects, class_name: 'CustomerConnect',foreign_key: :customer_id
    has_many :pending_friends, through: :pending_customer_connects, source: :friend
    has_many :requested_customer_connects, class_name: 'CustomerConnect',foreign_key: :customer_id
    has_many :requested_friends, through: :requested_customer_connects, source: :friend
    has_many :accepted_customer_connects, class_name: 'CustomerConnect',foreign_key: :friend_id
    #has_many :accepted_connects, class_name: 'CustomerConnect',foreign_key: :customer_id || :friend_id

  #scope :customer, -> { where(user_id: :current_user) }
  #scope :eposts, -> (customer_id) { where(customer_id: id) }
  #scope :confirmed_posters, -> (status) { where(status: 'confirmed') }
  scope :the_employer, -> { where(customer_type: :employer) }
  scope :the_employee, -> { where(customer_type: :employee) }
  scope :most_recent_first, -> {order("customers.created_at DESC")}
  scope :active_users, -> {where(status: 'active')}
  #geocoded_by :myaddress 
  geocoded_by :mystate
  after_validation :geocode
  #after_validation :geocode, if: ->(obj){ obj.myaddress.present? and obj.myaddress_changed? }

  def myaddress
   [address,city,state,country].compact.join(',')
  end
  def mystate
   [city, state,country].compact.join(',')
  end
  def address_changed?
    address_changed? || city_changed? || state_chaanged? || country_changed?
  end
  def full_name
   [firstname,lastname].join(' ')
  end
  
  def create_activity(item, action)
   activity = activities.new
   activity.targetable = item
   activity.action = action
   activity.save
   activity
  end
  

end
