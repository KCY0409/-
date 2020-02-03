# 지도 그리기
# 한국에서의 좌표계
# 한국은 크게 UTM-K와 WGS84(위경도)를 가장 많이 사용하고 있으며 지도에 관련된 api를 제공하는 서비스에서 사용할 때 중요한 인자
# WGS84 :위성이 사용하고 있는 좌표계이며 구글 지도가 표준으로 사용
# UTM - K : 국제 표준 좌표계중 하나인 UTM좌표계를 한국지리에 맞게 보정한 좌표계로 단위가 미터단위라 거리에 대한 감각이 직관적이기에 많이 사용 / 네이버 지도가 사용

# ggmap
# ggmap은 구글 지도를 배경으로 ggplot을 사용할 수 있게 해주는 패키지로 
# 내부적으로 모두 ggplot의 함수를 사용해 문법이 호환됨.

# gecoding
# gecoding이란 글자로 이루어져 있는 주소를 위경도로 바꾸는 것을 뜻
# 반대로 위경도로 구성된 위치정보를 그 위치의 대표값(주소,건물 이름 등)으로 바꾸는 것도 가능
# ggmap은 geocode()함수를 제공
geocode(location, output = "latlon", source = "google")
# location : 주소나 선물 이름에 해당하는 변환하고자 하는 값
# output : "latlon"."latlona","more","all"의 4가지 옵션이 있으며 뒤로 갈수록 정보가 상세
# source : 구글의 공개된 API를 사용한다는 뜻으로 대량으로 사용하기 위해서는 api -key를 등록해야 하거나 돈을 지불해야 할 수 있음 

# ggmap으로 ggplot객체로 만들기
# get_googlemap() 함수는 google지도를 ggmap 객체로 가져오는 함수입니다. 그래서 추가적으로 ggmap()함수를 이용해서 ggplot객체로 변환해야 함
# windows는 인코딩 문제가 있어서 URLencode(enc2utf8("장소")) 의 형태로 사용해야 합니다.
if(!require("ggmap")) install.packages("ggmap")
library(ggplot2)
library(ggmap)
# for windows
loc <- URLencode(enc2utf8("서울"))
tar <- URLencode(enc2utf8("서울시청"))
geocityhall <-geocode(tar)
#Error: Google now requires an API key. See ?register_google for details. -> API 등록이 필요한 듯 
get_googlemap(loc,
              maptype = "roadmap",
              markers = geocityhall) %>%
  ggmap()




