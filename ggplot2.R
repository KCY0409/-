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

# color 정보를 aes를 이용해서 mapping하기
(p_point_color <- p +
    geom_point(aes(color = continent)))
summary(p_point_color)

# geom 특징 조절하기
# 기하 객체의 각 특징은 굳이 데이터에 매핑 될 필요없이 조절 가능 
# 아래 두  summary를  확인해서 정보가 어떻게 다른지 확인
summary(p + geom_point(alpha = (1/3), size = 3 ))
summary(p + geom_point(aes(alpha = (1/3), size = 3)))

p + geom_point(alpha = (1/3), size = 3)

# stat_*()함수로 layer추가하기
# stat_*()함수는 geom_*() 함수의 특별한 형태로써 통계적인 기능들이 추가되어 동작 
# geom_*() 힘수 내에서도 통계함수들을 사용해 구현 가능

# stat_smooth로 간단히 추세선 추가하기
p_point
p_point + stat_smooth()

# method를 lm(선형회귀)로 변경
p_point + stat_smooth()
p_point + geom_smooth(lwd = 2,
                      se = FALSE,
                      method = "lm")

# 색정보를 전체에 반영하기
# layer를 추가할 때 작성한 mapping 정보는 이후에 더해지는 layer에 반영되지 않음
# 그렇기 때문에 공통으로 사용하는 mapping 정보는 최초 ggplot 객체 생성시 aes() 항수로 반영해야 함
p_point_color +
  geom_smooth(lwd = 2 , se = FALSE)

p + aes(color = continent) +
  geom_point() +
  geom_smooth(lwd = 1, se = FALSE)

# group과 color
p + aes(color = continent) +
  geom_point() +
  geom_smooth(lwd = 2, se  = FALSE)

p + aes(group = continent) +
  geom_point() +
  geom_smooth(lwd = 2 , se = FALSE)

# group으로 차트 나눠 그리기
# 대륙을 기준으로 차트를 그룹지어 나누어 그리기 가능 --> facet_*()함수 참고
(lp <- ggplot(gapminder) +
    geom_jitter(aes(x = year, y = lifeExp)))

lp + facet_wrap(~ continent)

# 실습2
# gapminder에서 pop 히스토그램을 그리세요
ggplot(gapminder,
        aes(x = pop)) + geom_bar()
ggplot(gapminder,
       aes(x =pop)) + geom_histogram()
# continent를 x축 , lifeExp를 y축으로 하는 바이올린차트를 그리고 평균을 파란색 점으로 추가
ggplot(gapminder,
       aes(x = continent, y = lifeExp, )) + 
  geom_violin() +
  geom_point(aes(color = mean(lifeExp)))

ggplot(gapminder,
       aes(x = continent, y = lifeExp, )) + 
  geom_violin() +
  stat_summary(color = "blue")
# 각 continent별로 총 몇개의 데이터가 있는지 세어 continent_freq를 만들고 bar차트를 그리세요.
continent_freq <- gapminder %>% count(continent)
ggplot(continent_freq,
       aes(x = continent, y = n)) + geom_bar(stat = "identity")
# Canada, Rwanda, Cambodia, Mexico 4 나라만 사용하여 x축은 year, y축은 lifeExp로 line 차트를 각 년도에 점을 추가하여 그리세요
FC <- gapminder %>% filter(country == c("Canada", "Rwanda", "Cambodia", "Mexico"))
ggplot(FC,
       aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()

jCountries <- c("Canada", "Rwanda", "Cambodia", "Mexico")
gapminder %>% filter(country %in% jCountries) %>%
  ggplot(aes(x = year, y = lifeExp, color = country)) +
  geom_line() + geom_point()


# 만든 그래프 정리하기
# ggplot2을 이용해 출력한 차트는 2가지 방식으로 저장 가능
# 하나는 rstudio에서 제공하는 GUI방식이고, 다은 하나는 패키지에서 지원하는 ggsave함수를 사용하는 방식
dir.create("../ggsave", showWarnings =  F)
ggsave("../ggsave/last.png")

# 여러 차트를 저장하기
# 계속 만드는 차트를 여러 번 저장해야 할때가 있다.
# for 문을 사용해 저장해야 하는데, 이름을 바꾸면서 저장
dir.create("../ggsave", showWarnings = F)
for(i in 1:length(unique(gapminder$country))){
  gapminder %>% filter(country == gapminder$country[i]) %>%
    ggplot(aes(x = year, y = lifeExp, color = country)) +
    geom_line() + geom_point() +
    ggsave(paste0("./ggsave/",gapminder$country[i],".png"))
  # print(paste0(i," / ",length(unique(gapminder$country))))
}























