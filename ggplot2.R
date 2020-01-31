# ggplot2
if(!requireNamespace("ggplot2")) install.packages("ggplot2")
library(ggplot2)

# 데이터를 기하 객체(geomeric object)의 미적 속성(aesthetic attributes)에 연결하는 방법
ggplot(data = mpg) +
  geom_point(aes(displ,hwy,
                 colour = class))

# Plot basics
# ggplot() == Create a new ggplot
# aes() == Construct aesthetic mappings
# '+'(<gg>) '%+%' == Add components to a plot
# ggsave() == Save a ggplot(or other grid object) with sensible defaults
# qplot() quickplot() == Qucik plot

# 용어 설명
# 기하 객체(geometric object) : 차트를 구성할 수 있는 그림의 형태들. bar,dot,line 등이 있음. geom_*() 형태의 함수로 layer를 구성함.
# 미적 속성(aesthetic attributes) : 각 기하 객체들의 모양을 결정하기 위한 요소들. 공통적으로 x,y,color 등이 있음.
# 연결(mapping) : 데이터의 컬럼을 필요한 미적 속성에 해당함을 명시적으로 작성하는 것. 
# ggplot 자료형 : ggplot()함수로 생성하는 R 객체로 그림을 그리기 위한 정보를 포함
# 계층(layer) : 제공된 데이터와 연결 정보를 바탕으로 그려진 그림. + 연사나를 통해 계층을 추가해 겹쳐서 그리는 것 가능 
# + 연산자 : 계층을 추가할 때 데이터와 연결 정보, 지금까지 작성된 계층 정보를 전달하는 연산자. %>%와 비슷
# 좌표계(coordinate system) : 대표적인 x-y 좌표계를 사용해 극좌표계(polar) 등으로 파이차트를 작성가능
# 축적(scale) : 데이터를 표시하는 방식으로 연속형 자료형에서 고려

# ggplot 객체
# ggplot은 그림 그리는 정보를 가지는 layer들을 겹쳐서 차트를 그리는 방식을 이용
# 대부분은 자동으로 지정을 해주고, 필수로 작성해야 하는 layer의 요소는 데이터, 연결정보, 기하 객체 입니다.
layer = ggplot(data, aes(<mapping>)) + geom_*
# 여러 layer를 겹칠 때 데이터와 연결정보 중에 공통으로 사용하는 것은 ggplot()함수로 작성해
# geom_요소만 + 연산자로 연결하여 layer를 겹치는 방식을 사용
ggplot(data, aes(<mapping>)) + # 공통 정보
  geom_요소1                   # 레이어 1의 구성
  geom_요소2                   # 레이어 2의 구성
  
# gapminder 데이터 소개
# 움직이는 버블차트로 유명한 데이터셋
if(!require("gapminder"))install.packages("gapminder")
library(gapminder)
str(gapminder)

p <- ggplot(data = gapminder,
            aes(x = gdpPercap, y = lifeExp))
p

p_point <- p + geom_point()
p_point

summary(p_point)
summary(p)

# 실습1
# 1. gapminder에서 country가 Afghanistan인 데이터만 뽑아서 gap_af로 저장하세요
View(gapminder)
# 행방향 조건 - filter / 열방향 조건 - select   기억해라 제발 
library(dplyr)
gap_af <- filter(gapminder, country == "Afghanistan")

# 2. gap_af를 X축은 year, y축은 lifeExp로 line 차트를 그리세요.
ggplot(data = gap_af,
       aes(x = year, y = lifeExp)) + geom_line()

# scale 변경하기
p_point
ggplot(gapminder) +
  geom_point(aes(x = log10(gdpPercap),
                 y = lifeExp))

# scale_* 함수로 변경하기
(p_point_log10 <- p_point + scale_x_log10())


