# Frage 3 (30P)

# Betrachten Sie den Datensatz "hflights" aus dem Paket `hflights`.
library(hflights)
library(tidyverse)
data("hflights")
summary(hflights)
# Es ist Ihre Aufgabe den Datensatz gemäß der Vorgaben in den Teilaufgaben zu 
# analysieren.
# Sie können Ihren Ansatz mit jeweiligen Tests überprüfen.
# Da Sie aber keine Funktionen schreiben, sind die Tests eher binär.
# Die Tests werden grün, wenn Sie die Aufgabe so gelöst haben, wie die 
# Musterlösung es erwartet.
# Für die Tests ist es wichtig, dass Sie die jeweiligen Objekte korrekt bezeichnen.
# Für reverse engineerte Tests ohne Code erhalten Sie Null Punkte.
# Die Tests sind immer gleich aufgebaut: Zunächst wird überprüft, ob Ihre Lösung 
# das richtige Format hat (z.B data.frame mit 10 Zeilen und 3 Spalten inkl. 
# Spaltennamen). Dann werden Statistiken Ihres Objektes (z.B. Median einer 
# speziellen Spalte) getestet.
# Im Umkehrschluss bedeutet das, dass, wenn erst die Assertions bzgl. der 
# Statistiken Fehler produzieren, die Format Checks bereits durchgelaufen sind.

# a)
# Wandeln Sie alle Spalten der Klasse `character` in eine Spalte der Klasse 
# `factor` um.
# Speichern Sie das Ergebnis in "ex0302a". Arbeiten Sie anschließend mit diesem 
# Datensatz weiter.
# Für diese Teilaufgabe steht Ihnen der Test "3.1" zur Verfügung.
ex0302a <- hflights %>% mutate_if(is.character, as.factor)

# b)
# Filtern Sie nach allen Flügen, die annulliert ("cancelled") wurden.
# Welche Fluggesellschaft hat die meisten Annullierungen?
# Beantworten Sie diese Frage mit einem `data.frame`, das für jeden `UniqueCarrier` 
# (Spalte 1) eine Anzahl `n` (Spalte 2) der Annullierungen enthält und sortieren 
# Sie es in absteigender Reihenfolge nach `n`.
# Speichern Sie das Resultat als `ex0302b`.
# Für diese Teilaufgabe steht Ihnen der Test "3.2" zur Verfügung.
ex0302b <- ex0302a %>% 
  filter(Cancelled == 1) %>% 
  count(UniqueCarrier) %>% 
  arrange(desc(n))


# c)
# Anstelle von absoluten Werten interessiert uns ein Annulierungs-Ratio pro Carrier.
# Berechnen Sie diesen Ratio und geben Sie ihn in einem `data.frame` mit zwei Spalten 
# (`UniqueCarrier` und `CancellationRatio`) aus.
# Sortieren Sie ihn so, dass die höchsten Ratios zuerst erscheinen.
# Runden Sie auf 4 Ziffern.
# Speichern Sie das Resultat als `ex0302c`.
# Für diese Teilaufgabe steht Ihnen der Test "3.3" zur Verfügung.
ex0302c <- ex0302a %>% 
  group_by(UniqueCarrier) %>% 
  summarise(CancellationRatio = round(mean(Cancelled), 4)) %>%
  arrange(desc(CancellationRatio))

# d)
# Als zweite Kennzahl interessiert uns die durchschnittliche Verzögerung (`MeanDelay`)
# bei der Ankunft (`ArrDelay`).
# Berechnen Sie diese Kennzahl  pro Fluggesselschaft (`Unique Carrier`).
# Achten Sie darauf, dass bei der Berechnung der Verspätung (`ArrDelay`), nur
# positive Werte für die Berechnung verwendet werden
# (eine negative Verspätung ist mit einer frühen Ankunft verbunden),
# grundsätzlich aber alle Daten verwendet werden.
# Runden Sie die Werte wie zuvor auf 4 Ziffern.
# Speichern Sie das resultierende `data.frame` mit zwei Spalten als `ex0302d`.
# Für diese Teilaufgabe steht Ihnen der Test "3.4" zur Verfügung.
ex0302d <- ex0302a %>% 
  mutate(ArrDelay = ifelse(ArrDelay < 0, NA, ArrDelay)) %>%
  group_by(UniqueCarrier) %>% 
  summarise(MeanDelay = round(mean(ArrDelay, na.rm = T), 4)) 

# e)
# Ermitteln Sie die Anzahl der Flüge, die mit Verspätung gestartet sind (`DepDelay`),
# aber ohne Verspätung landen konnten (`ArrDelay`).
# Speichern Sie das Resultat als `ex0302e`.
# Für diese Teilaufgabe steht Ihnen der Test "3.5" zur Verfügung.
ex0302e <- ex0302a %>% 
  filter(DepDelay > 0 & ArrDelay < 0) %>% 
  count() %>%
  pull(n)



以下是 **问题 3** 的完整解答和代码实现：

---

### **问题 3 (30分)**

#### **a) 将所有字符列转换为因子列**
将 `hflights` 数据集中所有 `character` 类型的列转换为 `factor` 类型，并将结果存储在 `ex0302a` 中。

```R
ex0302a <- hflights %>% mutate_if(is.character, as.factor)
```

- **说明**：使用 `mutate_if` 函数检查每一列是否为 `character` 类型，如果是，则将其转换为 `factor` 类型。
- **测试**：使用测试 "3.1" 验证结果。

---

#### **b) 过滤所有被取消的航班，并统计每家航空公司的取消次数**
过滤出所有被取消的航班（`Cancelled == 1`），并统计每家航空公司（`UniqueCarrier`）的取消次数。结果按取消次数降序排列，并存储在 `ex0302b` 中。

```R
ex0302b <- ex0302a %>% 
  filter(Cancelled == 1) %>% 
  count(UniqueCarrier) %>% 
  arrange(desc(n))
```

- **说明**：
  - `filter(Cancelled == 1)`：筛选出被取消的航班。
  - `count(UniqueCarrier)`：统计每家航空公司的取消次数。
  - `arrange(desc(n))`：按取消次数降序排列。
- **测试**：使用测试 "3.2" 验证结果。

---

#### **c) 计算每家航空公司的取消比率**
计算每家航空公司的取消比率（`CancellationRatio`），即取消航班数占总航班数的比例。结果按取消比率降序排列，并存储在 `ex0302c` 中。

```R
ex0302c <- ex0302a %>% 
  group_by(UniqueCarrier) %>% 
  summarise(CancellationRatio = round(mean(Cancelled), 4)) %>%
  arrange(desc(CancellationRatio))
```

- **说明**：
  - `mean(Cancelled)`：计算取消比率（`Cancelled` 列的平均值）。
  - `round(..., 4)`：将结果四舍五入到小数点后 4 位。
  - `arrange(desc(CancellationRatio))`：按取消比率降序排列。
- **测试**：使用测试 "3.3" 验证结果。

---

#### **d) 计算每家航空公司的平均到达延误时间**
计算每家航空公司的平均到达延误时间（`MeanDelay`），仅考虑正值的 `ArrDelay`（即实际延误的航班）。结果按航空公司分组，并存储在 `ex0302d` 中。

```R
ex0302d <- ex0302a %>% 
  mutate(ArrDelay = ifelse(ArrDelay < 0, NA, ArrDelay)) %>%
  group_by(UniqueCarrier) %>% 
  summarise(MeanDelay = round(mean(ArrDelay, na.rm = TRUE), 4))
```

- **说明**：
  - `mutate(ArrDelay = ifelse(ArrDelay < 0, NA, ArrDelay))`：将负值的 `ArrDelay` 替换为 `NA`，表示忽略提前到达的航班。
  - `mean(ArrDelay, na.rm = TRUE)`：计算平均延误时间，忽略 `NA` 值。
  - `round(..., 4)`：将结果四舍五入到小数点后 4 位。
- **测试**：使用测试 "3.4" 验证结果。

---

#### **e) 统计起飞延误但准时到达的航班数量**
统计起飞延误（`DepDelay > 0`）但准时到达（`ArrDelay < 0`）的航班数量，并将结果存储在 `ex0302e` 中。

```R
ex0302e <- ex0302a %>% 
  filter(DepDelay > 0 & ArrDelay < 0) %>% 
  count() %>%
  pull(n)
```

- **说明**：
  - `filter(DepDelay > 0 & ArrDelay < 0)`：筛选出起飞延误但准时到达的航班。
  - `count()`：统计符合条件的航班数量。
  - `pull(n)`：提取统计结果的值。
- **测试**：使用测试 "3.5" 验证结果。

---

### **总结**
- 每个子任务的输出都存储在一个特定的变量中（`ex0302a` 到 `ex0302e`）。
- 每个任务都附带了相应的测试（"3.1" 到 "3.5"），用于验证结果的正确性。
- 代码使用了 `tidyverse` 包中的函数（如 `mutate_if`、`filter`、`group_by`、`summarise` 等），确保数据处理和分析的简洁性和可读性。
