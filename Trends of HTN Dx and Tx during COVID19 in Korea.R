#### <2015~2020 새로 진단받은/치료받은 고혈압 대상자수 추출>
  #기존에 공단자료에서 SAS SQL procedure 이용해 고혈압대상자 데이터 추출함
  #해당 추출 파일은 CSV파일로 반출함


##★(1)  공단데이터 SAS-sql 추출 코드예시 (하기 형태를 매크로화해서 진행)
proc sql;
create table CA_temp as
select T20.indi_dscm_no, CALIST.ca, 변수들
from TAble as T40
  inner join R.ca_out as CALIST
  on substr(T40.mcesx_sick_sym,1,3) = CALIST.icd
  inner join TAble2 as T20 on T40.cmn_key = T20.cmn_key
  where PREV.indi_dscm_no is null
    and sick_clsf_type<>'3'
    and form_cd in ('02','03','04')
    groub by T20.indi_dscm_no, CALIST.ca
    ;
quit;
    
  
  #library(tidyverse)

##★(2) 시각화를 위한 데이터조작1
  #jk_pop; 자격테이블의 자격인구수
  #전체 2015~2020 newly dx/tx그리기
NEW<-htn_count_mmf%>%
  filter(str_sub(std_yyyymm,1,4)%in%c(2015:2020))%>%
  group_by(std_yyyymm)%>%
  mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
         jk_pop=sum(jk_pop), #자격인구수
         dx=sum(dx), #진단자수
         tx=sum(tx))%>% #치료자수
  group_by(year)%>%select(-std_yyyymm, -sex, -age_grp)%>% 
  unique%>%
  mutate(dx=sum(dx),
         tx=sum(tx))
write.csv(NEW, 'New_all.csv')

##★(3) 시각화를 위한 데이터조작2
  #COVID-19 유행하던 2018~2020기준
  #시,도별
NEW_SD <- htn_count_mmf_sd%>%filter(str_sub(std_yyyymm,1,4)%in%c(2018,2019,2020))%>%
  select(std_yyyymm,sd_type,dx,tx,jk_pop)%>%
  mutate(year=as.factor(str_sub(as.character(std_yyyymm),1,4)),
         month=as.factor(str_sub(as.character(std_yyyymm),5,6)),
         month=fct_relevel(month, '01','02','03','04','05','06','07','08','09','10','11','12'),
         sd_type=as.factor(case_when(sd_type%in%c(11)~'Seoul', #시,도코드
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
  #전국 연월별 
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
  #전국+시도별 연결
NEW_SD3<-   rbind(NEW_SD,NEW_SD2)%>%
  group_by(std_yyyymm,sd_type)%>%
  drop_na(sd_type)%>%unique()%>%
  mutate(
    sd_type=fct_relevel(sd_type,'Nationwide', 'Seoul', 'Incheon and Gyeonggi','Gangwon', 'Daejeon, Segjong, and Chungcheong',
                        'Gwangju and Jeolla', 'Daeju', 'Gyeongbuk', 'Busan, Ulsan, and Gyeongnam',
                        'Jeju')
  )%>%filter(str_sub(std_yyyymm,1,4)%in%c(2015:2020))%>%
  arrange_all

##★(4) 시각화 (descritive analysis)
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
    # strip.placement='inside'#없어도되긴함
    strip.text.x=element_text(size=10)
  )+
  scale_y_continuous(labels=scales::label_comma())+#label_number(scale=1e-3))+
  scale_color_manual(values=c('grey70', 'grey20','red'))

