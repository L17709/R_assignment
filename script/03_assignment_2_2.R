# 2-2-1 获取 ACCIDENT 和 PERSON 两个文件的交集
# 导入 dplyr 包
library(dplyr)
# 读取第一个 CSV 文件
data_person <- read.csv("data/2023-11-02_data-assignment/data-assignment/CRSS/PERSON.csv")
# 读取第二个 CSV 文件
data_accident <- read.csv("data/2023-11-02_data-assignment/data-assignment/CRSS/ACCIDENT.csv")
# 转换数据格式，不使用科学计数法
options(scipen = 200)
# 获取两个数据框的交集
intersection <- inner_join(data_person, data_accident, by = c("CASENUM", "VE_FORMS", "REGION", "PSU", "PJ", 
                                                              "PSU_VAR", "URBANICITY", "STRATUM", "MONTH", 
                                                              "HOUR", "MINUTE", "HARM_EV", "MAN_COLL", 
                                                              "SCH_BUS", "PSUSTRAT", "WEIGHT")
                           )
# 获取交集的行数和列数
dim(intersection)

# 2-2-2 统计实验对象中每种受伤程度的人数
data_each_injury_severity = data_person %>%
  group_by(INJ_SEV) %>%
  summarise(count=n())

# 2-2-3 合并 ACCIDENT 和 VEHICLE 两个文件，输出结果数据集的维度以及结果数据集中缺失值的数量
data_vehicle <- read.csv("data/2023-11-02_data-assignment/data-assignment/CRSS/VEHICLE.csv")
data_accident_vehicle <- left_join(data_accident, data_vehicle, by = c("CASENUM", "REGION", "PSU", "PJ", 
                                                                       "PSU_VAR", "URBANICITY", "STRATUM", 
                                                                       "VE_FORMS", "MONTH", "HOUR", "MINUTE",
                                                                       "HARM_EV", "MAN_COLL", "PSUSTRAT", "WEIGHT")
                                   )
# 获取结果数据集的行数和列数
dim(data_accident_vehicle)
# 获取结果数据集中缺失值的数量
sum(is.na(data_accident_vehicle))
