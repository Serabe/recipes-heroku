class ShowStepSerializer < ActiveModel::Serializer
  self.root = 'step'
  attributes :id, :position, :instruction
end
