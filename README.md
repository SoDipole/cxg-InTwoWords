# одним словом | двумя словами | в двух словах | два слова о(б)

### Материалы
[Ссылка на таблицу с данными](https://docs.google.com/spreadsheets/d/1pV8erjjqK9cju3X6_uyabb314O03z6Jc_bqWG_NFfpU/edit?usp=sharing)  
[Ссылка на код, здесь целиком с комментарием](https://github.com/...)

## Рабочая гипотеза

В языке ... конструкция "..." чаще встречается при таких-то условиях, чем альтернативная ей конструкция "...". На выбор конструкции могут также оказывать влияние такие-то социолингвистические / лингвистические факторы.

## Данные

### Материал исследования
Данные по запросам из НКРЯ + ruskell
Примеров:
- в двух словах: 98   
- два слова о  : 96
- двумя словами: 93
- одним словом :100

### Факторы выбора конструкции
Какая переменная является зависимой в дальнейшем анализе, от каких других переменных она предположительно зависит. Рекомендуется также обсудить независимость факторов, их корреляцию и т.д. Кроме того, можно обсудить, разметка каких параметров вызывала трудности.

## Анализ: дескриптивная статистика
В этом разделе располагаются таблицы, графики и обсуждение дистрибуции значений в отдельных переменных и взаимной дистрибуции пар переменных.
Рекомендуются гистограммы, density plots, боксплоты (или violin plots), метрики корреляции и статистической значимости. Если вы используете метрику хи-квадрат, не забывайте посчитать к ней effect size.

## Мультифакторный анализ
Здесь рекомендуется использовать один из следующих подходов к моделированию/анализу данных:  
* коллострукционный анализ (в сопоставлении с метриками из Schmid et al.)  
* дерево решений ( + случайный лес для выявления важности переменных (variable importance))  
* логистическая регрессия (привести примеры нескольких моделей, закончив оптимальной, в которой остаются только значимые факторы)  
* (множественный) анализ соответствий ((M)CA), возможно, в сочетании с кластеризацией/k-means  
Требуется показать output модели(ей) и привести графики

## Содержательный лингвистический анализ результатов статистического анализа
Без содержательного анализа факторов выбора конструкции (взаимодействия выделенных вами переменных, их значимости/важности) проект не будет считаться выполненным.   

## Обсуждение использованных квантитативных методов
Тут или ранее по ходу анализа нужно обсудить аккуратность (точность) классифицирующих моделей, classification power, adjusted R2, goodness of fit и т.п. -- стандартные показатели качества моделирования, а также важность / значимость факторов. 
В заключение вы можете предложить идеи по дальнейшей работе с данными и их статистическим анализом. 
