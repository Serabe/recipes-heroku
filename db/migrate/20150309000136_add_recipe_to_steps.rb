class AddRecipeToSteps < ActiveRecord::Migration
  def change
    add_reference :steps, :recipe, index: true
    add_foreign_key :steps, :recipes
  end
end
