# Frage 1 (15P)

# Reproduzieren Sie die Grafik "Q1plot.png" in Ihrem Repository so genau wie möglich.
# Verwenden Sie bei Bedarf die `tidyverse`-Pakete zum Preprocessen und verwenden
# Sie `ggplot2` zum Plotten.
# Außerdem kann es hilfreich sein das Paket `lubridate` zu verwenden.
# Verwenden Sie die `hflights` Daten aus dem `hflights` Paket (`data("hflights")`).
# Für diese Aufgabe sind keine automatisierten Tests vorgesehen.
# Die durchschnittliche Verspätung wird als `mean` über alle existenten `ArrDealay`s
# gebildet.
# Als Datengrundlage dient der Datensatz `hflights`, der alle Abflüge an den
# Flughäfen in Houston über einen gewissen Zeitraum abbildet.
# Abgebildet in den einzelnen Subplots sind diese Mittelwerte pro Monat.
# Etwaige Filter und Datentransformationen müssen Sie aus dem Plot ableiten.
# Eine Reproduktion in Englischer Sprache ist zulässig.

# 问题 1 (15分)

# 请尽可能精确地复制您仓库中的图表 "Q1plot.png"。
# 如果需要，可以使用 `tidyverse` 包进行预处理，并使用 `ggplot2` 进行绘图。
# 此外，使用 `lubridate` 包可能会有所帮助。
# 请使用 `hflights` 包中的 `hflights` 数据 (`data("hflights")`)。
# 此任务不提供自动化测试。
# 平均延误时间是通过对所有存在的 `ArrDelay` 取 `mean` 来计算的。
# 数据基础是 `hflights` 数据集，该数据集记录了休斯顿机场在一段时间内的所有航班起飞情况。
# 各个子图中展示的是每个月的这些平均值。
# 您需要从图表中推断出可能的过滤和数据转换。
# 允许使用英语进行复制。

# 加载hflights包中的hflights数据集，并将其赋值给变量flights
flights <- hflights::hflights %>%
  # 过滤掉被取消的航班（Cancelled == 0表示航班未被取消）
  filter(Cancelled == 0) %>%
  # 按照Month（月份）和DayOfWeek（星期几）对数据进行分组
  group_by(Month, DayOfWeek) %>%
  # 计算每个分组中ArrDelay（到达延误时间）的平均值，并忽略无效值
  summarise(avg_delay = mean(ArrDelay, na.rm = TRUE)) %>%
  # 将DayOfWeek（星期几）从数字转换为带有标签的因子（例如，1变为"Mon"，2变为"Tue"等）
  mutate(DayOfWeek = wday(DayOfWeek, label = TRUE)) 

# 使用ggplot2包绘制图形，绘制折线图，x轴为Month，y轴为avg_delay
ggplot(flights, aes(x = Month, y = avg_delay)) + 
  geom_line() + 
  # 按照DayOfWeek（星期几）进行分面，每个星期几单独绘制一个子图，并使用浅色背景，设置y轴标签：平均延误时间
  facet_wrap(~DayOfWeek) + theme_light() + ylab("Durchs. Verspätung (Minuten)") +
  # 设置x轴的刻度为1到12，并将刻度标签转换为月份的缩写
  scale_x_continuous(breaks = 1:12, labels = month(1:12, label = TRUE)) + 
  # 调整x轴刻度文本的角度为45度，并垂直和水平对齐
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust = 1)) +
  # 设置图表的标题
  ggtitle("Verspätungen an den Flughäfen in Houston (ohne Stornierungen)")

