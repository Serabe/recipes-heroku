class Ingredient < ActiveRecord::Base
  validates :name, presence: true

  def active_model_serializer
    if self.valid?
      ::ShowIngredientSerializer
    else
      ::ErrorIngredientSerializer
    end
  end
end
