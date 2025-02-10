# Frage 4 (30P)

# Sie implementieren das Spiel "Runner".
# Sie spielen das Spiel mit einem Kartendeck aus vier Farben ("rot", "blau", "grün", "gelb"),
# die jeweils Karten mit Zahlen von eins bis 13 enthalten.
# Das Spiel kann mit einem Geber ("Dealer") und einem bis fünf Spielern gespielt werden.
# Das Spiel beginnt, wenn der Geber eine Karte vom Stapel zieht.
# Er fragt den ersten Spieler, ob die aktuelle Karte eine höhere,
# niedrigere oder gleiche Zahl als die vorherige Karte hat.
# Der Spieler erhält 1 Punkt, wenn er richtig liegt, und 1 Minuspunkt, wenn er falsch liegt.
# Die Karte, die der vorherige Spieler erraten musste, ist nun die Karte,
# die der nächste Spieler erraten muss.
# Das Spiel geht weiter, bis keine Karte mehr im Stapel ist.
# Ihre Funktionen werden automatisiert getestet.
# Die Objekte, die Sie in a) und b) erstellen können Sie auch testen.
# Fehlermeldungen aus den Beispielen müssen Sie nicht exakt replizieren.
# Diese geben aber Aufschluss darüber, was Sie abfangen müssen.

# a)
# Erstellen Sie einen `data.frame`, das als Datenbasis dient,
# um alle 52 Karten im Deck anzuzeigen, so dass jede Karte eindeutig identifiziert werden kann.
# Nennen Sie das `data.frame` "ex04adeck".
# Nennen Sie die Spalten "colour" und "number".
# 创建一个名为 ex04adeck 的数据框（data.frame）
ex04adeck <- data.frame(
  # 创建一个名为 colour 的列，表示卡片的颜色
  # rep() 函数用于重复向量中的元素
  # 这里重复颜色向量 c("red", "blue", "green", "yellow") 13 次
  # 结果是一个长度为 52 的字符向量（13 * 4 = 52）
  colour = rep(c("red", "blue", "green", "yellow"), 13L),
  # 创建一个名为 number 的列，表示卡片的数字
  # 使用 rep() 函数重复数字 1 到 13，每个数字重复 4 次
  # each = 4L 表示每个数字连续重复 4 次
  # 结果是一个长度为 52 的数值向量（13 * 4 = 52）
  number = rep(1:13, each = 4L)
)

# b)
# Dies ist Ihr Starter Deck.
# Aus technischen Gründen müssen wir auch die aktuelle Karte und die Historie der Karten festhalten.
# Dieser Slot wird zunächst aber leer bleiben.
# Erstellen Sie eine Liste namens "ex04bdeck",
# die diese Einträge mit den Namen "card", "deck" und "history" enthält.
# Da wir noch nicht gespielt haben, sollten "card" und "history" leer sein.
# Das Element deck soll das in der Voraufgabe erstellte Deck enthalten.
ex04bdeck <- list(card = NULL, deck = ex04adeck, history = NULL)

# 创建一个名为 ex04bdeck 的列表（list）
# ex04bdeck <- list(
  
#   # 第一个元素名为 card，表示当前抽出的牌
#   # 初始值为 NULL，表示尚未抽出任何牌
#   card = NULL,
  
#   # 第二个元素名为 deck，表示完整的牌堆
#   # 使用之前创建的 ex04adeck 数据框作为初始牌堆
#   deck = ex04adeck,
  
#   # 第三个元素名为 history，表示抽牌的历史记录
#   # 初始值为 NULL，表示尚未有抽牌记录
#   history = NULL
# )
# 这段代码可以用于模拟一个抽牌系统：

# deck：表示完整的牌堆，可以从中抽牌。

# card：表示当前抽出的牌，初始为空。

# history：用于记录每次抽牌的历史，方便回溯。

# c)
# Implementieren Sie ein Ziehen aus dem Deck als eine `R` Funktion.
# Ihre Funktion sollte eine benannte Liste zurückgeben,
# bei der der erste Eintrag die Reihe ist, die aus dem Deck gezogen wurde,
# und der zweite Eintrag das verbleibende Deck ohne die gezogene Karte ist.
# Der Verlauf (history) entspricht allen Karten, die aus dem Deck gezogen wurden,
# in chronologischer (absteigender) Reihenfolge.
# Alle Einträge sollten, sofern nicht leer, den gleichen Typ/die gleiche Klasse haben.
# Die Einträge sollten "card" und "deck", "history" genannt werden.
# Ignorieren Sie zunächst die "history" und erfassen Sie diese im Ziehen nicht.
# Nennen Sie die Funktion `ex04draw`.
# Sie benutzt das "Deck" als Eingabe und hat ein optionales Startargument.
# Die Eingabe "deck" sollte das gleiche Format haben wie die Ausgabe.
# Stellen Sie sicher, dass der Seed nur gesetzt wird, wenn er angegeben wird,
# so dass die Funktion standardmäßig zufällig arbeitet.
# Verwenden Sie die bereitgestellte Signatur.
# Ihnen stehen die Tests "4.31", "4.32" und "4.33" zur Verfügung.

# Eingabe
# `deck`: Eine Liste, die den Anforderungen für ein Deck aus b) entspricht.
# `seed`: Numerisches Skalar. Der Seed für das Generieren von Zufallszahlen.

# Ausgabe
# Ein `deck`, mit einer Karte weniger in `$deck` im Vergleich zum Input.
# Die entfernte Karte wird in `$card` als ein `data.frame` mit einer Zeile dargestellt.

# Beispiele
# example_deck <- list(
#  card = NULL,
#  deck = data.frame(colour = c("black", "orange", "white", "black"),
#                    number = c(8, 9, 1, 3)),
#  history = NULL)
# it does not matter which card is actually transferred
# ex04draw(example_deck, seed = 8L)
#> $card
#>  colour number
#>4  black      3
#>
#>$deck
#>  colour number
#>1  black      8
#>2 orange      9
#>3  white      1
#>
#>$history
#>NULL

# example_deck <- list(
#  card = NULL,
#  deck = data.frame(colour = c("black", "orange", "white", "black"),
#                    number = c(8, 9, 1, 3),
#                    irrelevant = c("A", "A", "C", "D")),
#  history = NULL)
# ex04draw(example_deck, seed = 8L)
#> $card
#>  colour number irrelevant
#>4  black      3          D
#>
#>$deck
#>  colour number irrelevant
#>1  black      8          A
#>2 orange      9          A
#>3  white      1          C
#>
#>$history
#>NULL

# example_deck <- list(
#  card = data.frame(colour = "green", number = 12),
#  deck = data.frame(colour = c("black", "orange", "white", "black"),
#                    number = c(8, 9, 1, 3)),
#  history = NULL)
# ex04draw(example_deck, seed = 8L)
#> $card
#>  colour number
#>4  black      3
#>
#>$deck
#>  colour number
#>1  black      8
#>2 orange      9
#>3  white      1
#>
#>$history
#>NULL

# 定义一个名为 ex04draw 的函数，用于从牌堆中随机抽出一张牌
# 参数：
#   - deck: 包含牌堆的列表（必须包含 deck$deck 数据框）
#   - seed: 随机种子（可选），用于控制随机抽牌的结果
ex04draw <- function(deck, seed = NULL) {
  # 如果提供了 seed 参数，则设置随机种子
  # 设置随机种子可以确保每次运行代码时，随机抽牌的结果相同
  if (!is.null(seed)) {
    set.seed(seed)
  } 
  # 使用 sample() 函数从牌堆中随机抽取一张牌的索引
  # 1:nrow(deck$deck) 生成牌堆中所有牌的索引
  # size = 1 表示只抽取一张牌
  to_draw <- sample(1:nrow(deck$deck), 1) 
  # 根据抽出的索引，从牌堆中获取对应的牌
  # drop = FALSE 确保返回的结果仍然是数据框（而不是向量）
  card <- deck$deck[to_draw, , drop = FALSE]
  # 将抽出的牌从牌堆中移除
  # 使用负索引 -to_draw 表示移除该行
  # drop = FALSE 确保返回的结果仍然是数据框
  deck <- deck$deck[- to_draw, , drop = FALSE]
  # 返回一个列表，包含以下内容：
  #   - card: 抽出的牌
  #   - deck: 移除抽出牌后的牌堆
  #   - history: 抽牌历史记录（此处为 NULL，未实现历史记录功能）
  list(card = card, deck = deck, history = NULL)
}

# d)
# Implementieren Sie die Entscheidung eines spielenden Individuums,
# das seine Entscheidung auf die vorherige (vor Beginn des Spiels) Verteilung der Zahlen stützt,
# d.h. das Individuum wird immer "größer" spielen, wenn eine Zahl kleiner als 7
# erscheint und "kleiner", wenn sie größer ist.
# Im Falle von 7 ist die Person unentschieden und trifft eine zufällige Entscheidung
# zwischen den gleich wahrscheinlichen Ereignissen (aus ihrer Sicht).
# Die Funktion nimmt die `card` (die Karte, über die entschieden werden soll) und
# das `deck` (das verbleibende Deck zum Zeitpunkt der Entscheidung) als Eingaben.
# Nennen Sie die Funktion `ex04decide_prior`.
# Die Funktion gibt einen skalaren Zeichenwert aus: "larger", "equal" oder smaller"
# (die getroffene Entscheidung).
# Verwenden Sie die bereitgestellte Signatur.
# Ihnen stehen die Tests "4.41", "4.42" und "4.43" zur Verfügung.

# Eingabe
# `card`: Ein `data.frame` mit einer Zeile und (mindestens) den zwei Spalten `colour` und `number`
# `deck`: Ein `data.frame` mit beliebig vielen Zeilen und (mindestens) den zwei Spalten `colour` und `number`

# Ausgabe
# Ein skalerer Character: entweder "smaller" oder "larger" gemäß der Angabe.

# Beispiele
# example_deck <- list(
#  card = data.frame(colour = "green", number = 12),
#  deck = data.frame(colour = c("black", "orange", "white", "black"),
#                    number = c(8, 9, 1, 3)),
#  history = NULL)
# ex04decide_prior(card = example_deck$card, deck = example_deck$deck)
#> [1] "smaller"

# example_deck <- list(
#  card = data.frame(colour = "green", number = 4),
#  deck = data.frame(colour = c("black", "orange", "white", "black"),
#                    number = c(8, 9, 1, 3)),
#  history = NULL)
# ex04decide_prior(card = example_deck$card, deck = example_deck$deck)
#> [1] "larger"

# 定义一个名为 ex04decide_prior 的函数，用于根据抽出的牌决定下一步的提示
# 参数：
#   - card: 抽出的牌，是一个包含 colour 和 number 的数据框
#   - deck: 牌堆（未在函数中使用，可能是为了扩展功能预留）
ex04decide_prior <- function(card, deck) {
  # 如果抽出的牌的数字大于 7，返回 "smaller"
  # 表示下一张牌的数字应该比当前牌小
  if (card$number > 7) return("smaller") 
  # 如果抽出的牌的数字小于 7，返回 "larger"
  # 表示下一张牌的数字应该比当前牌大
  if (card$number < 7) return("larger")
  # 如果抽出的牌的数字等于 7，随机返回 "smaller" 或 "larger"
  # 使用 sample() 函数从 c("smaller", "larger") 中随机选择一个
  if (card$number == 7) return(sample(c("smaller", "larger"), 1L))
}

# e)
# Vervollständigen Sie die nachstehende Funktion "reward",
# die die Punkte für eine bestimmte Entscheidung (`decision`)und die Zahl,
# die Sie wählen (`new_number`) , mit der Zahl der offenen Karte (`old_number`) vergleicht.
# Ihnen stehen die Tests "4.51", "4.52" und "4.53" zur Verfügung.

# Eingabe
# `decision`: Ein skalarer character, die Entscheidung,
# die vor dem Zug der neuen Karte getroffen wurde.
# Muss entweder "larger", "smaller" oder "equal" sein.
# `new_number`: Ein skalarer Numeric, die Nummer der neu gezogenen Karte
# `old_number`: Ein skalerer Numeric, die Nummer der offenen Karte

# Ausgabe
# `numeric(1)`, entweder -1 oder 1.

# Beispiele
# ex04reward("equal", 2, 6)
#> [1] -1

# ex04reward("equal", 5, 5)
#> [1] 1

# ex04reward("larger", 5, 6)
#> [1] -1

# ex04reward("smaller", 5, 6)
#> [1] 1

# ex04reward("larger", -5, 6)
#> Error in ex04reward("larger", -5, 6) :
#>  Assertion on 'new_number' failed: Element 1 is not >= 1.

# ex04reward("larger", c(1, 1), 1)
#> Error in ex04reward("larger", c(1, 1), 1) :
#>  Assertion on 'new_number' failed: Must have length <= 1, but has length 2.


# 定义一个名为 ex04reward 的函数，用于根据决策和牌的数字计算奖励分数
# 参数：
#   - decision: 决策，必须是 "larger"、"smaller" 或 "equal" 之一
#   - new_number: 新牌的数字
#   - old_number: 旧牌的数字
ex04reward <- function(decision, new_number, old_number) {
  # 检查 decision 参数是否合法
  # 如果 decision 不是 "larger"、"smaller" 或 "equal" 之一，抛出错误
  if (!decision %in% c("larger", "smaller", "equal")) {
    stop("decision must be one of larger, smaller, equal")
  }
  # 使用 checkmate 包中的 assert_integerish 函数检查 new_number 是否为整数类型
  # 并且确保其值大于等于 1，长度为 1
  checkmate::assert_integerish(new_number, lower = 1L, max.len = 1L)
  # 使用 checkmate 包中的 assert_integerish 函数检查 old_number 是否为整数类型
  # 并且确保其值大于等于 1，长度为 1
  checkmate::assert_integerish(old_number, lower = 1L, max.len = 1L)
  # 根据 decision 的值计算奖励分数
  if (decision == "larger") {
    # 如果 decision 是 "larger"，判断新牌的数字是否大于旧牌的数字
    if (new_number > old_number) {
      points <- 1 # 如果满足条件，奖励 1 分
    } else {
      points <- -1 # 如果不满足条件，扣 1 分
    }
  }
  if (decision == "smaller") {  # 如果 decision 是 "smaller"，判断新牌的数字是否小于旧牌的数字
    if (new_number < old_number) { 
      points <- 1 # 如果满足条件，奖励 1 分
    } else {
      points <- -1 # 如果不满足条件，扣 1 分
    }
  }
  if (decision == "equal") { # 如果 decision 是 "equal"，判断新牌的数字是否等于旧牌的数字
    if (new_number == old_number) {
      points <- 1 # 如果满足条件，奖励 1 分
    } else {
      points <- -1 # 如果不满足条件，扣 1 分
    }
  }
  # 返回计算出的奖励分数
  points
}
