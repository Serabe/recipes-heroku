FactoryGirl.define do
  factory :recipe do
    name "My Recipe"
    description "My beautiful description"

    transient do
      steps_count 0
    end

    after :create do |recipe, evaluator|
      unless evaluator.steps_count.zero?
        FactoryGirl.create_list :step, evaluator.steps_count, recipe: recipe
        recipe.steps(true)
      end
    end
  end
end
