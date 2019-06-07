class Turn < ApplicationRecord
  include AASM

  belongs_to :consulting_room, required: false

  enum specialty: [
    :general_practitioner,
    :medical_specialist,
    :surgery,
    :exam_taking,
    :sampling,
    :claim_results,
    :x_rays,
    :therapies,
    :claim_medication
  ]

  before_create :calculate_code

  aasm column: :status do
    state :pending, initial: true
    state :attending
    state :attended

    event :called do
      transitions to: :attending, from: [:pending]
    end

    event :finalize do
      transitions to: :attended, from: [:pending, :attending]
    end
  end

  def get_code
    specialty.humanize.titlecase.split(' ').map { |w| w[0] }.join('') + ' ' + code.to_s
  end

  def calculate_code
    self.code = Turn.where(specialty: self.specialty).count + 1
  end
end
