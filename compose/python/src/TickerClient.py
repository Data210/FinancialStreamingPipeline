import websocket
import json
import os
import dotenv
import rel

dotenv.load_dotenv()
websocket.enableTrace(False)

class TickerClient():
    def __init__(self,ticker) -> None:
        self.receiver = None
        self.ticker = ticker
        self.ws = websocket.WebSocketApp(f"wss://ws.finnhub.io?token={os.getenv('FINNHUB_API_KEY')}",
                            on_message = self.on_message,
                            on_error = self.on_error,
                            on_open= self.on_open,
                            on_close = self.on_close)
        self.ws.run_forever(dispatcher=rel)

    def on_message(self, ws, message):
        decoded = json.loads(message)
        print(decoded)
        try:
            data = decoded['data']
        except:
            print("UNHANDLED BODY:",decoded)
            return
        print(f"TICKER@{data[0]['s']}")
        for trade in data:
            print(f"({decoded['type']}) {trade['v']}@{trade['p']}")
        
        if self.receiver:
            self.receiver(decoded)

    def on_error(self, ws, error):
        raise error

    def on_close(self, ws):
        print("### closed ###")

    def on_open(self, ws):
        ws.send(f'{{"type":"subscribe","symbol":"{self.ticker}"}}')

    def set_receiver(self,callback):
        self.receiver = callback