class ShowRecipeSerializer < ActiveModel::Serializer
  self.root = 'recipe'
  embed :ids, include: true
  attributes :id, :name, :description, :partial

  has_many :steps

  def partial
    false
  end
end
