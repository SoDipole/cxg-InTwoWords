# одним словом | двумя словами | в двух словах | два слова о(б)

### Материалы
[Данные](https://github.com/SoDipole/cxg-InTwoWords/master/data.csv)  
[Код с комментариями](https://github.com/SoDipole/cxg-InTwoWords/master/analize.R)

## Рабочая гипотеза

Четыре конструкции: одним словом | двумя словами | в двух словах | два слова о(б) <br />
Предположительно употребление зависит от параметров:
- Literal (буквально ли имеется в виду количество слов)
- Question (в составе вопроса / просьба рассказать кратко)
- Negation (в составе отрицания / невозможность передать кратко)
- VerbTalk (есть ли глагол предикат)

## Данные

### Материал исследования
Данные по запросам из НКРЯ + ruskell. Разммечены вручную.<br />
Примеров:
- в двух словах: 98   
- два слова о  : 96
- двумя словами: 93
- одним словом :100


### Факторы выбора конструкции

Зависимая переменная - одна из 4 конструкций (target). <br />
Предположительно:
- "в двух словах" - чаще всего Literal, а одним словом - реже всего.
- "два слова о" - чаще всего Question, и VerbTalk
- "в двух словах" - чаще других Negation
- VerbTalk и Negation - коррелируют

## Анализ: дескриптивная статистика
![barplot](https://raw.githubusercontent.com/SoDipole/cxg-InTwoWords/master/barplot.PNG "barplot")
![corrplot](https://raw.githubusercontent.com/SoDipole/cxg-InTwoWords/master/corrplot.png "corrplot")

## Мультифакторный анализ

* дерево решений ( + случайный лес для выявления важности переменных (variable importance))  
```
> importance(fit_forest)
         в двух словах два слова о двумя словами одним словом MeanDecreaseAccuracy MeanDecreaseGini
Literal      25.749453    6.263400    48.8484026     4.736283            44.795051        24.730736
Question      8.187191    3.834931    -0.1053812    -2.928081             4.858301         2.397233
Negation      8.398397    4.118263     6.6402473    10.678680            13.674868         6.215489
VerbTalk     34.484909    3.742125    34.9384720    53.818682            64.196396        45.777577
```
![rand_forest_importance](https://raw.githubusercontent.com/SoDipole/cxg-InTwoWords/master/rand_forest_importance.png "rand_forest_importance")
```
> table(Test$target, PredictCART)
               PredictCART
                в двух словах два слова о двумя словами одним словом
  в двух словах            19           0             1            9
  два слова о              10           0             0           19
  двумя словами             9           0            17            2
  одним словом              0           0             1           29
```
![tree](https://raw.githubusercontent.com/SoDipole/cxg-InTwoWords/master/tree.png "tree")

* логистическая регрессия (привести примеры нескольких моделей, закончив оптимальной, в которой остаются только значимые факторы)  
"одним словом" vs. "два слова о" <br />
Все переменные:
```
Call:
glm(formula = target ~ Literal + Question + Negation + VerbTalk, 
    family = binomial, data = df_subset)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-2.9750  -0.7147   0.4887   0.4887   2.3152  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   2.0649     0.2334   8.848  < 2e-16 ***
Literal       2.3485     0.5503   4.268 1.98e-05 ***
Question     -1.4412     0.7796  -1.849  0.06452 .  
Negation     -1.3745     0.5036  -2.729  0.00634 ** 
VerbTalk     -1.8582     0.2975  -6.245 4.24e-10 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 437.97  on 386  degrees of freedom
Residual deviance: 345.36  on 382  degrees of freedom
AIC: 355.36

Number of Fisher Scoring iterations: 5
```
Только Literal и VerbTalk:
```
Call:
glm(formula = target ~ Literal + VerbTalk, family = binomial, 
    data = df_subset)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-3.0399  -1.1522   0.5036   0.5036   1.2029  

Coefficients:
            Estimate Std. Error z value Pr(>|z|)    
(Intercept)   2.0011     0.2271   8.811  < 2e-16 ***
Literal       2.6096     0.5444   4.794 1.64e-06 ***
VerbTalk     -2.0608     0.2826  -7.293 3.04e-13 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 437.97  on 386  degrees of freedom
Residual deviance: 357.37  on 384  degrees of freedom
AIC: 363.37

Number of Fisher Scoring iterations: 5
```

## Содержательный лингвистический анализ результатов статистического анализа
Корреляция:
<br /> VerbTalk и Negation - коррелируют, как ожидалось
<br /> Но больше всего - VerbTalk и Literal
<br /> Negation и Literal - взаимоисключающие 
<br /><br />
Выводы:
- "одним словом" чаще всего в качестве в качестве вводной конструкции, значит не буквально и без предиката
- "двумя словами" - самое буквальное и чаще всего с глаголами
- "в двух словах" - часто с глаголами, но не буквальное
- "два слова о" - не предсказывается выбранными параметрами среди 4 конструкций

## Обсуждение использованных квантитативных методов
Далее: сравнение между каждыми двумя. Интереснее - между "двумя словами" | "в двух словах"
