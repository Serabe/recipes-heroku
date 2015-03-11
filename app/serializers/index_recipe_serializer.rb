class IndexRecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :partial

  def partial
    true
  end
end
