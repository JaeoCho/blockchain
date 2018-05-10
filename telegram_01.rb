require 'telegram/bot'
require 'httparty'
require 'json'

token = '510615997:AAEJ2ri0FCHdDYHEuDme8h-1lL5iYBgej7U'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/price'
    	5.times do
	    	url = 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'

			total_price = HTTParty.get(url).body
			parsed_price = JSON.parse(total_price)
			target_price = parsed_price["price"]
			float_price = target_price.to_f
			final_price = float_price.round(0)
			msg_price = "현재 비트코인 가격은 " + final_price.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse + "달러 입니다.\n"

			url = 'https://api.fixer.io/latest?base=USD'
			rate = HTTParty.get(url).body
			parsed_rate = JSON.parse(rate)
			final_rate = parsed_rate["rates"]["KRW"]

			msg_price << "원화 가격은 " + (float_price*final_rate.to_f).round(0).to_s.reverse.gsub(/...(?=.)/,'\&,').reverse + "원 입니다.\n"


			url = 'https://crix-api-cdn.upbit.com/v1/crix/candles/minutes/30?code=CRIX.UPBIT.KRW-BTC'
			upbit_price = HTTParty.get(url).body
			upbit_parsed_rate = JSON.parse(upbit_price)
			upbit_final_rate = upbit_parsed_rate[0]["tradePrice"]
			float_final_upbit_price = upbit_final_rate.to_f
	
			kp = ((float_final_upbit_price - float_price * final_rate.to_f) / (float_price * final_rate.to_f)) * 100
	
			msg_price << "프리미엄 : " + kp.round(2).to_s + "%"
	
	    	bot.api.send_message(chat_id: message.chat.id, text: msg_price)
	    	sleep(5)
	    end


    end
  end
end