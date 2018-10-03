class TransactionsController < ApplicationController
  def create
    current_user.buy(transaction_params[:stock_id], transaction_params[:number_of_shares].to_i )
    redirect_to home_path
  end
end

private

  def transaction_params
    params.require(:transactions).permit(:stock_id, :number_of_shares)
  end
