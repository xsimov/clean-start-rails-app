class Expense < Transaction
  validates :transaction_category_id, presence: true

  belongs_to :transaction_category

  def category
    transaction_category.name
  end

  def parent_category
    transaction_category.parent_category&.name
  end
end
