class NbpCurrencyService
  ALLOWED_CURRENCIES = %w[usd eur chf gbp]

  attr_reader :currency, :start_date, :end_date

  def initialize(currency, start_date, end_date)
    @currency = currency
    @start_date = start_date
    @end_date = end_date
  end

  def get_result
    return nil unless check_if_params_wrong

    currency_values_array = get_currencies
    standard_deviation = calculate_deviation(currency_values_array)
    average_price = calculate_average(currency_values_array)
    {
      standard_deviation: standard_deviation.round(4),
      average_price: average_price.round(4)
    }
  end

  private

  def get_currencies
    url = URI.parse("http://api.nbp.pl/api/exchangerates/rates/a/#{currency}/#{start_date}/#{end_date}/")
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    res = JSON.parse(res.body)
    res["rates"].map{ |rate| rate["mid"] }
  end

  def calculate_deviation(currency_array)
    mean = currency_array.inject(:+) / currency_array.length.to_f
    var_sum = currency_array.map{|n| (n-mean)**2}.inject(:+).to_f
    variance = var_sum / (currency_array.length - 1)
    Math.sqrt(variance)
  end

  def calculate_average(currency_array)
    currency_array.reduce(:+) / currency_array.size.to_f
  end

  def check_if_params_wrong
    ALLOWED_CURRENCIES.include?(currency.downcase) && date_valid?(start_date) && date_valid?(end_date)
  end

  def date_valid?(date)
    format = '%Y-%m-%d'
    DateTime.strptime(date, format)
    true
  rescue ArgumentError
    false
  end
end
