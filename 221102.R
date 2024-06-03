# install.packages("forecast") #Arima()함수유용함
# install.packages('scales')
# install.packages('gridExtra')
# install.packages('tidyverse')
# install.packages('https://cran.r-project.org/src/contrib/Archive/tidyverse/tidyverse 1.3.0.tar.gz', repos=NULL,
                 # type='source', INSTALL_opts=c('--no-lock'))
update.packages(checkBuilt=TRUE, ask=FALSE)

library(tidyverse)
library(scales)
library(gridExtra)
# library(forecast)

# # getwd()
# # setwd("C:/Users/hunhan925/Desktop/mosi/mosi")
# #의료이용자수_연령별 전체 데이터프레임:
# PREV <- read.csv("C:/Users/모시/OneDrive/바탕 화면/htn_prepare/HTNFACT22_COUNTMMF_AGE/HTN22_COUNT_AGE.csv", header=TRUE, skip=1)%>%
#   filter(STD_YYYY %in% 2016:2020)%>%rename_with(tolower)%>%
#   select(std_yyyy:tx,jk_pop)
# str(PREV)
# 
# # ?print()
# # ?summarize_at()
# # 2016~2020: 전체 의료이용자수 그래프
# # par(mfrow=c(1,1), mar=c(5.1,4.1,4.1,2.1)  # 기본값.
#     
# # 성별
# PREV2 <- PREV%>%group_by(std_yyyy, sex)%>%
#   summarize_at(vars(dx:tx),sum,na.rm=T)%>%
#   pivot_longer(dx:tx, names_to='prev', values_to='cnt')
#   
# ggplot(PREV2,aes(x=std_yyyy, y=cnt, group=prev, color=prev))+
#       facet_wrap(vars(sex))+#, scales='free_x')+
#   geom_line()+
#       geom_point(data=transform(PREV2, sex=NULL),color='grey85')+
#   geom_point()
#   labs(title='의료이용자수(진단/치료기준), 2016-2020')+
#   xlab('연도')+ylab('(천) 명')+
#   theme_bw()+
#       theme(
#     plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
#     legend.background=element_rect(fill='white',size=0.5, color='black'),
#     legend.justification=c(0,0.5),
#     axis.title.y=element_text(angle=360, vjust=1, hjust=0),  
#     # legend.position=c(0,0)
#     axis.ticks=element_line(color='grey70',size=1),
#     panel.grid.major = element_line(colour = "grey70", size = 0.03, linetype='dashed'),
#     panel.grid.minor = element_blank(),
#     axis.text.y=element_text(vjust=0.5),
#     legend.title=element_blank(),
#     legend.text=element_text(vjust=0.5),
#     legend.text=c('진단기준', '치료기준')
#    )+
#       scale_y_continuous(labels=scales::label_number(scale=1e-3))
#   
# # 연령별
#   PREV3 <- PREV%>%
#         mutate(age_grp=ifelse(age_grp%/%10*10>=60,'60+',age_grp%/%10*10))%>%
#                         group_by(std_yyyy, age_grp)%>%
#         summarize_at(vars(dx:tx),sum,na.rm=T)%>%
#         pivot_longer(dx:tx, names_to='prev', values_to='cnt')
#   
#   ggplot(PREV3,aes(x=std_yyyy, y=cnt, group=prev, color=prev))+
#         facet_wrap(vars(age_grp), scales='free')+
#         geom_line()+
#         # geom_point(data=transform(PREV3, age_grp=NULL), color='grey85')+
#         geom_point()+
#         labs(title='의료이용자수(진단/치료기준), 2016-2020')+
#         xlab('연도')+ylab('(천) 명')+
#         theme_bw()+
#         theme(
#               plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
#               legend.background=element_rect(fill='white',size=0.5, color='black'),
#               legend.justification=c(0,0.5),
#               axis.title.y=element_text(angle=360, vjust=1, hjust=0),  
#               # legend.position=c(0,0)
#               axis.ticks=element_line(color='grey70',size=1),
#               panel.grid.major = element_line(colour = "grey70", size = 0.03, linetype='dashed'),
#               panel.grid.minor = element_blank(),
#               axis.text.y=element_text(vjust=0.5),
#               legend.title=element_blank(),
#               legend.text=element_text(vjust=0.5)
#              )+
#         scale_y_continuous(labels=scales::label_number(scale=1e-3))
#   
  
  
#     
# # new visit(발생자수) 2016-2020
#   NEW <- read.csv("C:/Users/hunhan925/Desktop/mosi/mosi/HTNFACT22_COUNTMMF_AGE.csv", header=TRUE, skip=1)%>%
#     filter(STD_YYYYMM %in% 201801:202012)%>%rename_with(tolower)%>%
#     select(std_yyyymm:tx,jk_pop)
#   str(NEW)
#   
# # new visit 전체(2015~2020, 연도별 dx | tx 추이비교)
#   NEW2 <- read.csv("C:/Users/hunhan925/Desktop/mosi/mosi/HTNFACT22_COUNTMMF_AGE.csv", header=TRUE, skip=1)%>%
#         filter(STD_YYYYMM %in% 201501:202012)%>%rename_with(tolower)%>%
#         select(std_yyyymm:tx,jk_pop)%>%
#         mutate(
#               year=factor(str_sub(as.character(std_yyyymm),1,4))
#               )%>%
#                group_by(year)%>%
#         summarize_at(vars(dx:tx),sum,na.rm=T)%>%
#         pivot_longer(dx:tx, names_to='new', values_to='cnt')%>%
#         mutate(new=factor(new, labels=c('diagnosis', 'treatment')))
#   
#   ggplot(NEW2,aes(x=year, y=cnt, group=new, color=new))+
#         # facet_wrap(vars(year), scales='free_x')+
#         geom_line()+
#         geom_point()+
#         geom_text(aes(label=cnt), vjust=-1.5, size=4, family='serif',parse=TRUE)+#(cnt,label_number(scale=1e-3))))+
#         labs(x='year', y='New visits for hypertension(diagnosed)')+
#         coord_cartesian(ylim=c(500000, 850000))+
#         theme_bw()+
#         theme(
#               # plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
#               legend.background=element_rect(fill='white',size=0.5, color='white'),
#               legend.justification=c(0,0.5),
#               axis.title.y=element_text(vjust=0.5, hjust=0.5),#angle=360, 
#               # legend.position=c(0,0)
#               axis.ticks=element_line(color='black', size=rel(0.2)),
#               panel.grid.major = element_line(colour = "grey90", size = 0.03), #linetype='dashed'),
#               # panel.grid.minor = element_blank(),
#               axis.text.y=element_text(vjust=0.5),
#               legend.title=element_blank(),
#               legend.text=element_text(vjust=0.5)
#               # legend.text=c('진단기준', '치료기준')
#         )+
#         scale_y_continuous(labels=scales::label_comma(scale=1e-0))+
#         # scale_size_manual(values=c(5,5,5,5,20))+
#         scale_color_manual(values=c('blue', 'orange'))
#  # ?theme() 
#   
#   
# 
#   
# # 5개년도, 07월~06월로 그래프, new visit그리기
#   NEW3 <- htn_count_mmf%>%mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
#                        month=as.factor(str_sub(as.character(std_yyyymm),5,6)),
#                        month=fct_relevel(month, '01','02','03','04','05','06','07','08','09','10','11','12'))%>%
#    group_by(year,month)%>%
#               summarize_at(vars(dx:tx),sum,na.rm=T)
# # 진단기준
# a <-   ggplot(NEW3,aes(x=month, y=dx, group=year, color=year))+
#     # facet_wrap(vars(year), scales='free_x')+
#     geom_line()+
#   # labs(title='New visits for hypertension, 2016-2020')+
#     xlab('Month')+ylab('New visits for hypertension, thousands(diagnosed)')+
#     theme_bw()+
#     theme(
#       # plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
#       legend.background=element_rect(fill='white',size=0.5, color='white'),
#       legend.justification=c(0,0.5),
#       axis.title.y=element_text(vjust=0.5, hjust=0.5),#angle=360, 
#       # legend.position=c(0,0)
#       axis.ticks=element_line(color='black', size=rel(0.2)),
#       panel.grid.major = element_line(colour = "grey90", size = 0.03), #linetype='dashed'),
#       # panel.grid.minor = element_blank(),
#       axis.text.y=element_text(vjust=0.5),
#       legend.title=element_blank(),
#       legend.text=element_text(vjust=0.5)
#       # legend.text=c('진단기준', '치료기준')
#     )+
#     scale_y_continuous(labels=scales::label_number(scale=1e-3))+
#     scale_size_manual(values=c(5,5,5,5,20))+
#       scale_color_manual(values=c('grey70', 'grey55','red'))
# # 치료기준
# b <- ggplot(NEW3,aes(x=month, y=tx, group=year, color=year))+
#     # facet_wrap(vars(year), scales='free_x')+
#     geom_line()+
#     # labs(title='New visits for hypertension, 2016-2020')+
#     xlab('Month')+ylab('New visits for hypertension, thousands(treated)')+
#     theme_bw()+
#     theme(
#       # plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
#       legend.background=element_rect(fill='white',size=0.5, color='white'),
#       legend.justification=c(0,0.5),
#       axis.title.y=element_text(vjust=0.5, hjust=0.5),#angle=360, 
#       # legend.position=c(0,0)
#       axis.ticks=element_line(color='black',size=rel(0.2)),
#       panel.grid.major = element_line(colour = "grey90", size = 0.03), #linetype='dashed'),
#       # panel.grid.minor = element_blank(),
#       axis.text.y=element_text(vjust=0.5),
#       legend.title=element_blank(),
#       legend.text=element_text(vjust=0.5)
#       # legend.text=c('진단기준', '치료기준')
#     )+
#     scale_y_continuous(labels=scales::label_number(scale=1e-3), limits=c(35000,70000))+
#       scale_color_manual(values=c('grey70', 'grey55','red'))
#     
# grid.arrange(a,b, nrow=1, ncol=2)
# # ?grid.arrange()


# 시도별 new visit, 07~06으로 그리기
# 전국, 11:서울특별시, 28:인천+41:경기도,42:강원도,30:대전광역시+36:세종특별자치시+43:충청북도+44:충청남도,
# 29:광주광역시+45:전라북도+46:전라남도, 27:대구, 47:경상북도, 26:부산광역시+31:울산광역시+48:경상남도, 
# 49:제주도+50:제주특별자치도
  # NEW_SD <- read.csv("C:/Users/hunhan925/Desktop/mosi/mosi/HTNFACT22_COUNTMMF_SD.csv", header=TRUE, skip=1)%>%
    # filter(STD_YYYYMM %in% 201801:202012)%>%rename_with(tolower)%>%
# NEW_SD <- htn_count_mmf_sd%>%group_by(std_yyyymm)%>%summarize(num=sum(jk_pop))


# 전체 2015~2020 newly dx/tx그리기
NEW<-htn_count_mmf%>%
  filter(str_sub(std_yyyymm,1,4)%in%c(2015:2020))%>%
  group_by(std_yyyymm)%>%
  mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
    jk_pop=sum(jk_pop),
         dx=sum(dx),
         tx=sum(tx))%>%group_by(year)%>%select(-std_yyyymm, -sex, -age_grp)%>%
  unique%>%
  mutate(dx=sum(dx),
         tx=sum(tx)
         )

write.csv(NEW, 'New_all.csv')

#  시도별 그리기
NEW_SD <- htn_count_mmf_sd%>%#filter(str_sub(std_yyyymm,1,4)%in%c(2018,2019,2020))%>%
    select(std_yyyymm,sd_type,dx,tx,jk_pop)%>%
        mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
                       month=as.factor(str_sub(as.character(std_yyyymm),5,6)),
                       month=fct_relevel(month, '01','02','03','04','05','06','07','08','09','10','11','12'),
                       sd_type=as.factor(case_when(sd_type%in%c(11)~'Seoul',
                                                   sd_type%in%c(28,41)~'Incheon and Gyeonggi',
                                                   sd_type%in%c(42)~'Gangwon',
                                                   sd_type%in%c(30,36,43,44)~'Daejeon, Segjong, and Chungcheong',
                                                   sd_type%in%c(29,45,46)~'Gwangju and Jeolla',
                                                   sd_type%in%c(27)~'Daeju',
                                                   sd_type%in%c(47)~'Gyeongbuk',
                                                   sd_type%in%c(26,31,48)~'Busan, Ulsan, and Gyeongnam',
                                                   sd_type%in%c(49,50)~'Jeju'
                                                   # TRUE~'NA'
                                                   )),
                       sd_type=fct_relevel(sd_type, 'Seoul', 'Incheon and Gyeonggi','Gangwon', 'Daejeon, Segjong, and Chungcheong',
                                           'Gwangju and Jeolla', 'Daeju', 'Gyeongbuk', 'Busan, Ulsan, and Gyeongnam',
                                           'Jeju')
                       )%>%group_by(std_yyyymm, sd_type)%>%
  mutate(jk_pop=sum(jk_pop),
         dx=sum(dx),
         tx=sum(tx))
  
  NEW_SD2 <-htn_count_mmf_sd%>%
    mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
                                   month=as.factor(str_sub(as.character(std_yyyymm),5,6)),
                                   month=fct_relevel(month, '01','02','03','04','05','06','07','08','09','10','11','12'),
                                   sd_type=as.factor('Nationwide')
    )%>%unique%>%
    group_by(std_yyyymm, sd_type)%>%mutate(jk_pop=sum(jk_pop),
                                           dx=sum(dx),
                                           tx=sum(tx)
                                           )
  
  
NEW_SD3<-   rbind(NEW_SD,NEW_SD2)%>%
      group_by(std_yyyymm,sd_type)%>%
        drop_na(sd_type)%>%unique()%>%
      mutate(
            sd_type=fct_relevel(sd_type,'Nationwide', 'Seoul', 'Incheon and Gyeonggi','Gangwon', 'Daejeon, Segjong, and Chungcheong',
                                'Gwangju and Jeolla', 'Daeju', 'Gyeongbuk', 'Busan, Ulsan, and Gyeongnam',
                                'Jeju')
      )%>%filter(str_sub(std_yyyymm,1,4)%in%c(2015:2020))%>%
      arrange_all



# ?summarize_at
# 진단기준
ggplot(NEW_SD3,aes(x=month, y=dx/jk_pop*100000, group=year, color=year,na.rm=T))+
    facet_wrap(vars(sd_type), nrow=2, ncol=5,scales='free_x')+
    geom_line()+
    # geom_line(NEW_SD2[year='2020'], color='red')+
    # labs(title='New visits for hypertension, 2018-2020')+
    xlab('Month')+ylab('Newly diagnosis for hypertension per 100,000 persons')+
    theme_bw()+
    theme(
      # plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
      legend.background=element_rect(fill='white',size=0.5, color='white'),
      legend.justification=c(0,0.5),
      axis.title.y=element_text(vjust=0.5, hjust=0.5),#angle=360, 
      # legend.position=c(0,0)
      axis.ticks=element_line(color='black',size=rel(0.2)),
      panel.grid.major = element_line(colour = "grey90", size = 0.03), #linetype='dashed'),
      # panel.grid.minor = element_blank(),
      axis.text.y=element_text(size=8,vjust=0.5),
      axis.text.x=element_text(size=8),
      legend.title=element_blank(),
      legend.text=element_text(vjust=0.5),
      # legend.text=c('진단기준', '치료기준')
      strip.background=element_blank(),
      # strip.placement='inside'#얘는 없어도되긴할듯
      strip.text.x=element_text(size=10)
    )+
    scale_y_continuous(labels=scales::label_comma())+#label_number(scale=1e-3))+
    scale_color_manual(values=c('grey70', 'grey20','red'))
      
 
  # ?facet_wrap
# ?cut_number
  # ?theme()
  # ?facet_wrap()
  # ?scale_x_continuous()
  
  # 치료기준
ggplot(NEW_SD3,aes(x=month, y=dx/jk_pop*100000, group=year, color=year,na.rm=T))+
  facet_wrap(vars(sd_type), nrow=2, ncol=5,scales='free_x')+
  geom_line()+
  # geom_line(NEW_SD2[year='2020'], color='red')+
  # labs(title='New visits for hypertension, 2018-2020')+
  xlab('Month')+ylab('Newly diagnosis for hypertension per 100,000 persons')+
  theme_bw()+
  theme(
    # plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
    legend.background=element_rect(fill='white',size=0.5, color='white'),
    legend.justification=c(0,0.5),
    axis.title.y=element_text(vjust=0.5, hjust=0.5),#angle=360, 
    # legend.position=c(0,0)
    axis.ticks=element_line(color='black',size=rel(0.2)),
    panel.grid.major = element_line(colour = "grey90", size = 0.03), #linetype='dashed'),
    # panel.grid.minor = element_blank(),
    axis.text.y=element_text(size=8,vjust=0.5),
    axis.text.x=element_text(size=8),
    legend.title=element_blank(),
    legend.text=element_text(vjust=0.5),
    # legend.text=c('진단기준', '치료기준')
    strip.background=element_blank(),
    # strip.placement='inside'#얘는 없어도되긴할듯
    strip.text.x=element_text(size=10)
  )+
  scale_y_continuous(labels=scales::label_comma())+#label_number(scale=1e-3))+
  scale_color_manual(values=c('grey70', 'grey20','red'))
  
  
  # 외래만!!!!!!!!!!!!!!!!!
# NEWF_SD <- read.csv("C:/Users/hunhan925/Desktop/mosi/mosi/HTNFACT22_COUNTMMFO_SD.csv", header=TRUE, skip=1)%>%
NEWF_SD <- htn_count_mmfo_sd%>%
  select(std_yyyymm,sd_type,dx,tx,jk_pop)%>%
  mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
         month=as.factor(str_sub(as.character(std_yyyymm),5,6)),
         month=fct_relevel(month, '01','02','03','04','05','06','07','08','09','10','11','12'),
         sd_type=as.factor(case_when(sd_type%in%c(11)~'Seoul',
                                     sd_type%in%c(28,41)~'Incheon and Gyeonggi',
                                     sd_type%in%c(42)~'Gangwon',
                                     sd_type%in%c(30,36,43,44)~'Daejeon, Segjong, and Chungcheong',
                                     sd_type%in%c(29,45,46)~'Gwangju and Jeolla',
                                     sd_type%in%c(27)~'Daeju',
                                     sd_type%in%c(47)~'Gyeongbuk',
                                     sd_type%in%c(26,31,48)~'Busan, Ulsan, and Gyeongnam',
                                     sd_type%in%c(49,50)~'Jeju'
                                     # TRUE~'NA'
         )),
         sd_type=fct_relevel(sd_type, 'Seoul', 'Incheon and Gyeonggi','Gangwon', 'Daejeon, Segjong, and Chungcheong',
                             'Gwangju and Jeolla', 'Daeju', 'Gyeongbuk', 'Busan, Ulsan, and Gyeongnam',
                             'Jeju')
  )%>%group_by(std_yyyymm, sd_type)%>%
  mutate(jk_pop=sum(jk_pop),
         dx=sum(dx),
         tx=sum(tx))

NEWF_SD2 <-htn_count_mmfo_sd%>%
  mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
         month=as.factor(str_sub(as.character(std_yyyymm),5,6)),
         month=fct_relevel(month, '01','02','03','04','05','06','07','08','09','10','11','12'),
         sd_type=as.factor('Nationwide')
  )%>%unique%>%
  group_by(std_yyyymm, sd_type)%>%mutate(jk_pop=sum(jk_pop),
                                         dx=sum(dx),
                                         tx=sum(tx)
  )


NEWF_SD3<-   rbind(NEWF_SD,NEWF_SD2)%>%
  group_by(std_yyyymm,sd_type)%>%
  drop_na(sd_type)%>%unique()%>%
  mutate(
    sd_type=fct_relevel(sd_type,'Nationwide', 'Seoul', 'Incheon and Gyeonggi','Gangwon', 'Daejeon, Segjong, and Chungcheong',
                        'Gwangju and Jeolla', 'Daeju', 'Gyeongbuk', 'Busan, Ulsan, and Gyeongnam',
                        'Jeju')
  )%>%filter(str_sub(std_yyyymm,1,4)%in%c(2018,2019))%>%
  arrange_all

# 진단/치료기준
ggplot(NEWF_SD3,aes(x=month, y=tx/jk_pop*100000, group=year, color=year,na.rm=T))+
  facet_wrap(vars(sd_type), nrow=2, ncol=5,scales='free_x')+
  geom_line()+
  # geom_line(NEW_SD2[year='2020'], color='red')+
  # labs(title='New visits for hypertension, 2018-2020')+
  xlab('Month')+ylab('Newly diagnosis for hypertension per 100,000 persons')+
  theme_bw()+
  theme(
    # plot.title=element_text(face='bold', size=15, hjust=0.5,vjust=0.5),
    legend.background=element_rect(fill='white',size=0.5, color='white'),
    legend.justification=c(0,0.5),
    axis.title.y=element_text(vjust=0.5, hjust=0.5),#angle=360, 
    # legend.position=c(0,0)
    axis.ticks=element_line(color='black',size=rel(0.2)),
    panel.grid.major = element_line(colour = "grey90", size = 0.03), #linetype='dashed'),
    # panel.grid.minor = element_blank(),
    axis.text.y=element_text(size=8,vjust=0.5),
    axis.text.x=element_text(size=8),
    legend.title=element_blank(),
    legend.text=element_text(vjust=0.5),
    # legend.text=c('진단기준', '치료기준')
    strip.background=element_blank(),
    # strip.placement='inside'#얘는 없어도되긴할듯
    strip.text.x=element_text(size=10)
  )+
  scale_y_continuous(labels=scales::label_comma())+#label_number(scale=1e-3))+
  scale_color_manual(values=c('grey70', 'grey20'))#,'red'))


  
  # ?unite
  # ?str_pad
  # setwd('C:/Users/hunhan925/Desktop/mosi/220811_다시데이터받음')
  
# getwd()
#외래+입원
htn_count <- readr::read_csv('C:/Users/mosethd.DOMAIN1/Desktop/공단분석업무관련/2022 고혈압관련분석 진행중/고혈압학회준비/HTN_221102/HTN22_COUNT_AGE.csv', skip = 1) %>%
      rename_with(tolower) %>%
      filter(age_grp >= 20)

htn_count_sd <- read_csv('HTN22_COUNT_SD.csv', skip = 1) %>%
      rename_with(tolower) %>%
        filter(age_grp >= 20)


# 전체 중 newly diagnosed (jk_pop 수정완료)
htn_count_mmf <- read_csv('HTNFACT22_COUNTMMF_AGE.csv', skip = 1) %>%
      rename_with(tolower) %>%
      select(-jk_pop) %>%
      filter(age_grp >= 20) %>%
      mutate(std_yyyymm = as.character(std_yyyymm)) %>%
      right_join(
      htn_count %>%
            select(std_yyyy, sex, age_grp, jk_pop) %>%
      expand_grid(mm = str_pad(1:12, 2, pad = '0')) %>%
      unite('std_yyyymm', std_yyyy, mm, sep = '')
            ,
            by = c('std_yyyymm', 'sex', 'age_grp')
      ) %>%
      mutate(dx = coalesce(dx, 0), tx = coalesce(tx, 0))

# 전체 중 시도별 newly diagnosed (jk_pop 수정완료)
htn_count_mmf_sd <- read_csv('HTN22_COUNTMMF_SD.csv', skip = 1) %>%
      rename_with(tolower) %>%
      select(-jk_pop) %>%
      filter(age_grp >= 20) %>%
      mutate(std_yyyymm = as.character(std_yyyymm)) %>%
      right_join(
            htn_count_sd %>%
                  select(std_yyyy, sd_type, sex, age_grp, jk_pop) %>%
                  expand_grid(mm = str_pad(1:12, 2, pad = '0')) %>%
                  unite('std_yyyymm', std_yyyy, mm, sep = '')
            ,
            by = c('std_yyyymm', 'sd_type', 'sex', 'age_grp')
      ) %>%
      mutate(dx = coalesce(dx, 0), tx = coalesce(tx, 0))

# mosi <- htn_count_mmf %>%
      # group_by(std_yyyymm)%>%
      # summarize_at(vars(dx:jk_pop), sum, na.rm=T)
      


# getwd()
htn_count <- read_csv('C:/Users/mosethd.DOMAIN1/Desktop/공단분석업무관련/2022 고혈압관련분석 진행중/고혈압학회준비/HTN_221102/HTN22_COUNT_AGE.csv', skip = 1) %>%
  rename_with(tolower) %>%
  filter(age_grp >= 20)

htn_count_sd <- read_csv('HTN22_COUNT_SD.csv', skip = 1) %>%
  rename_with(tolower) %>%
  
  filter(age_grp >= 20)


# 전체 중 newly diagnosed (jk_pop 수정완료)
htn_count_mmfo <- read_csv('HTN22_COUNTMMFO_AGE.csv', skip = 1) %>%
  rename_with(tolower) %>%
  select(-jk_pop) %>%
  filter(age_grp >= 20) %>%
  mutate(std_yyyymm = as.character(std_yyyymm)) %>%
  right_join(
    htn_count %>%
      select(std_yyyy, sex, age_grp, jk_pop) %>%
      expand_grid(mm = str_pad(1:12, 2, pad = '0')) %>%
      unite('std_yyyymm', std_yyyy, mm, sep = '')
    ,
    by = c('std_yyyymm', 'sex', 'age_grp')
  ) %>%
  mutate(dx = coalesce(dx, 0), tx = coalesce(tx, 0))

# 전체 중 시도별 newly diagnosed (jk_pop 수정완료)
htn_count_mmfo_sd <- read_csv('HTN22_COUNTMMFO_SD.csv', skip = 1) %>%
  rename_with(tolower) %>%
  select(-jk_pop) %>%
  filter(age_grp >= 20) %>%
  mutate(std_yyyymm = as.character(std_yyyymm)) %>%
  right_join(
    htn_count_sd %>%
      select(std_yyyy, sd_type, sex, age_grp, jk_pop) %>%
      expand_grid(mm = str_pad(1:12, 2, pad = '0')) %>%
      unite('std_yyyymm', std_yyyy, mm, sep = '')
    ,
    by = c('std_yyyymm', 'sd_type', 'sex', 'age_grp')
  ) %>%
  mutate(dx = coalesce(dx, 0), tx = coalesce(tx, 0))


  
  
  
  
  
  
  
  
  
  
  
  
  
#' 
#' 
#' #의료이용자수_시도별 전체 데이터프레임: 
#' SD <- read.csv("C:/Users/mosethd.DOMAIN1/Desktop/공단분석업무관련/2022 고혈압관련분석 진행중/HTN22_COUNT_SD.csv", header=TRUE, skip=1)%>%
#'   filter(STD_YYYY %in% 2016:2020)%>%rename_with(tolower)%>%
#'   select(std_yyyy:tx,jk_pop)
#' str(SD)
#' 
#' PREV %>%
#'       group_by(STD_YYYY,SEX)%>%
#'       summarize(pop=sum(DX, na.rm=TRUE))
#' #mutate대신 transmute사용해서 깔끔하게 남기는것도 좋을 듯
#' #mutate대신 summarize를 사용하면 새로운 요약변수가 생성되는 동시에 언급하지 않은 것들은 없어지므로 깔끔해짐
#' #summarize를 애용하자
#' # 집계함수의 경우 na.rm=T 옵션을 통해 결측값을 제외한 집계결과를 얻을 수 있음
#' prev_sex_TX <- read.csv("C:/Users/hunhan925/Desktop/mosi/HTN22_COUNT_AGE.csv", header=TRUE, skip=1)%>%
#'   select(STD_YYYY:TX,JK_POP,-AGE_GRP)%>%group_by(STD_YYYY,SEX)%>%summarize(pop=sum(TX, na.rm=TRUE))
#' #성별+연도별 진단자/치료자 기준 의료이용자수
#' prev_age_DX <- read.csv("C:/Users/hunhan925/Desktop/mosi/HTN22_COUNT_AGE.csv", header=TRUE, skip=1)%>%
#'   select(STD_YYYY:TX,JK_POP,-SEX)%>%group_by(STD_YYYY,AGE_GRP)%>%summarize(pop=sum(DX, na.rm=TRUE))
#' prev_age_TX <- read.csv("C:/Users/hunhan925/Desktop/mosi/HTN22_COUNT_AGE.csv", header=TRUE, skip=1)%>%
#'   select(STD_YYYY:TX,JK_POP,-SEX)%>%group_by(STD_YYYY,AGE_GRP)%>%summarize(pop=sum(TX, na.rm=TRUE))
#' #데이터 확인하는작업
#' str(prev_sex_DX)
#' dim(prev_sex_DX)
#' 
#' #위에 데이터프레임을 가지고 심미성매핑을 해보자
#' #'facet_wrap(~이산형변수, nrow=n)'을 이용하여 면분할해보자'
#' ggplot(prev_sex_DX, aes(x=STD_YYYY,y=pop,colour=factor(SEX)))+
#'   geom_line()+
#'   geom_point()+
#'   facet_wrap(SEX~.) 
#' # facet_wrap(~SEX.) # facet_wrap(~SEX, nrow=1)
#' #aes인수에서 group의 역할은 무엇인가: group심미성을 설정해서 다중객체를 그릴 수 있다
#' #ylim은 y축의 범위를 지정
#' #stat: 시각화에 적용될 통계요소
#' #position: 시각화에 적용될 위치요소
#' #bins: x축을 나누는 bin의 개수 설정
#' #binwidth: x축을 나누는 bin의 너비 설정, 숫자벡터를 사용할 수 있다(bin과 binwidth는 동시에 사용될 수 없다).
#' #na.rm: 결측치를 제거할지를 결정하는 논리값(FALSE이면 warning메세지와 함께 결측치가 제거되고
#' #TRUE이면 조용히 제거됨)
#' #orientation: 레이어의 원점설정(x가 default)
#' #show.legend: 범례를 표시할지에 대한 논리값
#' #inherit.aes: ggplot()에서 설정한 매핑값을 상속받을지 결정하는 논리값
#' #pad: TRUE이면 x값이 끝나는 곳에 empty bins을 추가하게 됨
#' 
#' #지옴의 stat을 변경할 수 있음; 예) geon_bar의 stat을 count에서 identity로 바꿀수 있음->y변수의 원 값을 막대높이로 정하게됨
#' 
#' 
#' ggplot(prev_sex_DX, aes(x=STD_YYYY, y=pop, color=factor(SEX), group=factor(SEX)))+
#'   geom_point()+
#'   geom_line()+
#'   ggtitle("진단기준 고혈압환자의 의료이용자수, 2002-2020")+
#'   xlab("연도(년)")+ylab("의료이용자수(명)")



# 예------------------------------------------시
#economics라는 데이터를 활용한 ITS 분석 예시
library(nlme)
head(economics)
ggplot(economics, aes(x=date,y=psavert))+
      geom_line()
#correlogram을 그려본다면 lag0의 값은 항상 1이다.(완전히 겹치므로 correlation=1.0)
model.lm <- lm(psavert~date, economics)
acf(resid(model.lm))#autocorrelation 확인
eventdate<-as.Date("2005-01-01") 
economics$postevent<-economics$date>=eventdate 
economics#확인차, postevent변수는 논리값으로 나오네
model.gls<-gls(psavert~date+postevent+date*postevent, data=economics, correlation=corAR1(0.8))#lag1의 값이 0.8이어서...?
economics$gls.fit<-model.gls$fitted 
ggplot(data=economics, aes(x=date, y=psavert))+
      geom_line()+
      geom_point(aes(x=date, y=gls.fit),col="blue",size=0.5)
#2005년 이후 level change와 slope change가 동시에 일어남을 알 수 있다

model.gls$coefficients
#date(pre event slope): -6.157878e-04
#date:posteventTRUE(post event slope): 2.184692e-03
#이것이 한달동안의 rate변화이므로 여기에 12를 곱하면 1년간의 변화. %를 위해 100을 곱한다
model.gls$coefficients*12*100
# pre event slope(per year)=-7.389453e-01
# post event slope(per year)=2.621631e+00

# 95%CI도 구하자
confint(model.gls)*12*100
# pre event slope(per year)=-8.341884e-01 -6.437023e-01
# post event slope(per year)=2.032291e+00  3.210971e+00
# conclusion: event발생 전의 private saving rate는 년간 0.739%씩 감소했고 95%CI[-0.834, -0.644]이다.
#           : event발생 후에는 년간 2.622%씩 증가했고 95%CI[2.032, 3.211]이다.


# ----------forecast---------------
AirPassengers
plot(AirPassengers, xlab="Time(monthly)", ylab="Numberof passengers", main="Airline passengers")
# auto.arima()는 fit an ARIMA(p,d,q)(P,D,Q)[s=12]model automatically; 가장 적합한 p,d,q,P,D,Q 모수를 찾아준다
airline.fit=auto.arima(AirPassengers)
airline.fit
# par(mflow=c(1,1)): 한패널에 한개의 그림을 그려주는 명령어
# forecast::plot()함수: 시계열자료의 그림을 그려주는 명령어
# 









?stat_bin
ggsave("plot.png", width=5, height=5)


