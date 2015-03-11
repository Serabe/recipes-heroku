class ShowStepSerializer < ActiveModel::Serializer
  self.root = 'step'
  embed :ids
  attributes :id, :position, :instruction

  has_one :recipe
end
