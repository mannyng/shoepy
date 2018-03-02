class JobLocation < ApplicationRecord
    belongs_to :employer_post
    #has_many :insights, through: :employer_post
    has_one :insight, through: :employer_post
    has_one :customer, through: :employer_post
    
    geocoded_by :co_address || :co_state
    after_validation :geocode, if: ->(obj){ obj.co_address.present? }
   # after_validation :geocode, if: :address_changed?

  def co_address
   [location,city,state,"nigeria"].compact.join(',')
  end
  def co_state
   [state,"nigeria"].compact.join(',')
  end
   def co_address_changed?
     co_address.changed?
   end
    
end
