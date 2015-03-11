class Recipe < ActiveRecord::Base
  has_many :steps,
           -> { order position: :asc },
           dependent: :destroy

  accepts_nested_attributes_for :steps, allow_destroy: true

  validates :name,
            presence: true,
            length: { minimum: 5 }

  validates :description,
            presence: true,
            length: { minimum: 10 }

  def active_model_serializer
    if self.valid?
      ::ShowRecipeSerializer
    else
      ::ErrorRecipeSerializer
    end
  end
end
