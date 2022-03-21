class NbpController < ActionController::Base
  def currency_info
    currency = params[:currency]
    start_date = params[:startDate]
    end_date  = params[:endDate]

    result = NbpCurrencyService.new(currency, start_date, end_date).get_result
    if result
      render json: result
    else
      render json: { errors: "Params are in a bad format" }, status: :unprocessable_entity
    end
  end
end