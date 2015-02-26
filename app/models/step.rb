class Step < ActiveRecord::Base
  validates :instruction,
            presence: true,
            length: { minimum: 5 }

  validates :position,
            presence: true,
            numericality: { only_integer: true,
                            greater_than_or_equal_to: 0}

end
