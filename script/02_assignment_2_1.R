# 2-1-1 获取 STATE_CODE 为 6 且 SHRP_ID 以 “050” 开头的子集
# 导入 dplyr 包
library(dplyr)
# 导入数据
iri <- read.csv("data/2023-11-02_data-assignment/data-assignment/LTPP/iri.csv")
# 获取子集
iri_subset <- iri %>%
  filter(STATE_CODE == 6 & substring(SHRP_ID, 1, 3) == "050")
# 获取 iri_subset 的行数和列数
dim(iri_subset)

# 2-1-2 获取每个组 IRI 的统计信息
IRI_summary_subset <- iri %>%
  group_by(STATE_CODE, SHRP_ID) %>%
  summarize(
    IRI_min = min(IRI, na.rm = TRUE), 
    IRI_max = max(IRI, na.rm = TRUE),
    IRI_mean = mean(IRI, na.rm = TRUE)
  )
# 获取 IRI_summary_subset 的行数和列数
dim(IRI_summary_subset)

# 2-1-3 以 IRI 的平均值降序进行排序
sorted_IRI_summary_subset <- IRI_summary_subset %>%
  arrange(desc(IRI_mean))
# 仅输出一个部分的结果
selected_section <- sorted_IRI_summary_subset[1, ]

# 2-1-4 绘制所选组 IRI 相对于时间的散点图
# 选取 STATE_CODE 为 6 且 SHRP_ID 以 "0aa602" 开头的组别
iri_subset_1 <- iri %>%
  filter(STATE_CODE == 6 & substring(SHRP_ID, 1, 4) == "0602")
# 导入 tidyr 包
library(tidyr)
# 对时间进行分割处理
iri_sep <- iri_subset_1 %>%
  tidyr::separate(col = VISIT_DATE, into = c("DATE", "TIME"), sep = ",") %>%
  tidyr::separate(col = DATE, into = c("MONTH", "DAY", "YEAR"), sep = "/")
# 对年份进行补全处理
for (i in 1:nrow(iri_sep)) {
  if (iri_sep$YEAR[i] <= "99" && iri_sep$YEAR[i] >= "06") {
    iri_sep$YEAR[i] <- paste("19", iri_sep$YEAR[i], sep="")
  } else {
    iri_sep$YEAR[i] <- paste("20", iri_sep$YEAR[i], sep="")
  }
}
# 以时间的升序进行排序
sorted_iri_subset_1 <- iri_sep %>%
  mutate(NEW_TIME = paste(YEAR, MONTH, DAY, TIME, sep = "/")) %>%
  arrange(NEW_TIME)
# 导入 ggplot2 包
library(ggplot2)
# 绘制散点图
ggplot(data = sorted_iri_subset_1, aes(x = NEW_TIME, y = IRI)) +
  geom_point() +
  labs(x = "时间", y = "均值") +
  ggtitle("均值时间图")  +
  theme(plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1)
  )
