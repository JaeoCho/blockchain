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
    	url = 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'

		total_price = HTTParty.get(url).body
		parsed_price = JSON.parse(total_price)
		target_price = parsed_price["price"]
		float_price = target_price.to_f
		final_price = float_price.round(1)
		msg_price = "현재 비트코인 가격은 " + final_price.to_s + "달러 입니다."

    	bot.api.send_message(chat_id: message.chat.id, text: msg_price)
    end
  end
end