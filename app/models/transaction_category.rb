class TransactionCategory < ApplicationRecord
  belongs_to :parent_category, class_name: 'TransactionCategory', optional: true
  has_many :children_categories, class_name: 'TransactionCategory', foreign_key: 'parent_category_id'

  scope :final_children, -> { where.not(parent_category_id: nil) }
end
