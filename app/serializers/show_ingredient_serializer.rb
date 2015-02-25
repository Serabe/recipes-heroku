class ShowIngredientSerializer < ActiveModel::Serializer
  self.root = :ingredient
  attributes :id, :name
end
