class AddingPlanTypetoSellers < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :plan_type, :integer, default: 0
  end
end
