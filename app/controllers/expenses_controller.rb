class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :prepare_categories_and_producers, only: %i[ edit new ]

  def index
    @expenses = Expense.all
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to new_expense_url, notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        prepare_categories_and_producers
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        prepare_categories_and_producers
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def prepare_categories_and_producers
    @categories = TransactionCategory.final_children
    @producers = Producer.all
  end

  def expense_params
    params.require(:expense).permit(:title, :value, :transaction_category_id, :purchased_on, :producer_id)
  end
end
