class EmailMessage
  include ActiveModel::Model

  attr_accessor :name, :company, :email, :phone, :preferred_method, :reason, :brief_msg

  REASONS = {
    :general_question => 'General Question',
    :job_offer_fulltime => 'Offer Full Time Position',
    :job_offer_consulting => 'Seeking Consultation',
    :job_offer_contract => 'Offer Contract-based Position',
    :provide_feedback => 'Provide Feedback'
  }

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates_presence_of   :name, :email, :phone, :preferred_method, :reason, :brief_msg
  validates_inclusion_of  :preferred_method, in: %w( email phone )
  validates_inclusion_of  :reason, in: %w( general_question job_offer_fulltime job_offer_consulting job_offer_contract provide_feedback )
  validates_length_of     :brief_msg, within: 1..255
  validates               :email, format: { with: EMAIL_REGEX, 
                                            message: 'is not valid' }
  validates               :phone, length: { minimum: 10, 
                                            maximum: 11,
                                            too_short: 'must have at least 10 digits',
                                            too_long: 'can\'t be more than 11 digits' },
                                  numericality: { only_integer: true }
  
  
end