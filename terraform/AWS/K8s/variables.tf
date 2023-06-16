variable "kube_config" {
  type    = string
  default = "~/.kube/config"
}

variable "namespace" {
  type    = string
  default = "financial-streaming-pipeline"
}

variable "finnhub_stocks_tickers" {
  type    = list
  default = [ "BINANCE:BTCUSDT",
              "BINANCE:ETHUSDT",
              "BINANCE:XRPUSDT",
              "BINANCE:DOGEUSDT" ]
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}