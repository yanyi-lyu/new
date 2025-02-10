# Frage 2: exchange_money (15P)

# Schreiben Sie eine Funktion, die Euros in US-Dollars umrechnet und vice versa.
# Verwenden Sie den Wechselkurs vom 09.01.2024: 1 USD = 0,92 EUR als Standardwert.
# Achten Sie darauf, alle Argumente gründlich zu überprüfen.
# Nennen Sie die Funktion `ex02exchange_money`.
# Ihnen stehen die Tests "2.1", "2.2" und "2.3" mit je mehreren Assertions zur Verfügung.


## Eingabe

# `value` Numerischer Vektor ohne fehlende Werte. Der Geldbetrag, der gewechselt wird
# `currency`: Character Skalar. Die Ausgangswährung, muss entweder "EUR" oder "USD" annehmen. Per Default: "USD"
# `eur_per_usd`: Numerischer Skalar (>0). Der Wechselkurs, zu dem gewechselt wird. Per Default: 0.92

## Ausgabe

#`numeric(n)`

## Beispiele

# 问题 2: exchange_money (15分)
# 编写一个函数，将欧元转换为美元，反之亦然。
# 使用 2024年1月9日 的汇率作为默认值：1 USD = 0.92 EUR。
# 请确保彻底检查所有参数。
# 将函数命名为 ex02exchange_money。
# 您可以使用测试 "2.1"、"2.2" 和 "2.3"，每个测试包含多个断言。
# 输入
# value: 数值向量，无缺失值。表示要兑换的金额。
# currency: 字符标量。表示原始货币，必须是 "EUR" 或 "USD"。默认值为 "USD"。
# eur_per_usd: 数值标量 (>0)。表示兑换汇率。默认值为 0.92。
# 输出
# numeric(n)：返回兑换后的金额，数值向量。

### 函数本身逻辑很简单，但是需要注意的是函数需要有已经的处理错误的能力，在这里就是应对不符合要求的输入的时候该如何报错

# 定义一个函数 ex02exchange_money，用于货币兑换
# 参数：
#   - value: 需要兑换的金额（数值类型）
#   - currency: 货币类型，默认为 "USD"（美元）
#   - eur_per_usd: 1 美元兑换欧元的汇率，默认为 0.92
ex02exchange_money <- function(value, currency = "USD", eur_per_usd = 0.92) {
  # 使用 checkmate 包中的 assert_numeric 函数检查 value 是否为数值类型
  # 如果 value 不是数值类型，会抛出错误
  checkmate::assert_numeric(value)

  # 使用 match.arg 函数检查 currency 参数是否为 "USD" 或 "EUR"
  # 如果不是，会抛出错误；如果是，返回匹配的值
  currency <- match.arg(currency, c("USD", "EUR"))

  # 使用 checkmate 包中的 assert_number 函数检查 eur_per_usd 是否为数值类型
  # 并且确保其值大于等于 0（lower = 0）
  # 如果不符合条件，会抛出错误
  checkmate::assert_number(eur_per_usd, lower = 0)

  # 根据 currency 的值进行货币兑换计算
  if (currency == "USD") {  # 如果 currency 是 "USD"，将 value 从美元转换为欧元
    value * eur_per_usd
  } else { # 如果 currency 是 "EUR"，将 value 从欧元转换为美元
    value / eur_per_usd
  }
}

# 测试部分，如下不重要

#ex02exchange_money(0.8)
#> [1] 0.736
#ex02exchange_money(0.8, "USD", 0.92)
#> [1] 0.736
#ex02exchange_money(2.44, "EUR", 0.92)
#> [1] 2.652174
#ex02exchange_money(0.8, "USD", 0.89)
#> [1] 0.712
#ex02exchange_money(1:4, "USD", 0.89)
#> [1] 0.89 1.78 2.67 3.56
#ex02exchange_money(c(1:4, NA), "USD", 0.89)
#> [1] 0.89 1.78 2.67 3.56   NA
#ex02exchange_money(c("Eins", 3, 3.1), "USD", 0.89)
#> Error in ex02exchange_money(c("Eins", 3, 3.1), "USD", 0.89) :
#>  Assertion on 'value' failed: Must be of type 'numeric', not 'character'.
#ex02exchange_money(1:4, "CAD", 0.89)
#> Error in match.arg(currency, c("USD", "EUR")) :
#>   'arg' should be one of “USD”, “EUR”

#' Currency conversion between EUR and USD
#' This function coverts EUR to USD and vice versa.
#' The exchange rate can be supplied manually but defaults to
#' 1 USD = 0.92 EUR
#' Arguments:
#' value: temperature in Fahrenheit or Celsius. A numeric vector.
#' currency: the currency that value is in. Must be "USD" for US Dollars or
#'           "EUR" for Euros.
#' eur_per_usd: The exchange rate EUR/USD, a numeric scaler.
#' Returns: a numeric vector indicating the temperature in Celsius.