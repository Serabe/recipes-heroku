class ShowRecipeSerializer < ActiveModel::Serializer
  self.root = 'recipe'
  attributes :id, :name, :description
end
