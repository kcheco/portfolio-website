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

  validates_presence_of :name, :email, :phone, :preferred_method, :reason, :brief_msg
  validates_inclusion_of :preferred_method, in: %w( email phone )
  validates_inclusion_of :reason, in: %w( general_question job_offer_fulltime job_offer_consulting job_offer_contract provide_feedback )
  validates_length_of :brief_msg, within: 1..255
end