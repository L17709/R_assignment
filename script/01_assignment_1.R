# 1-1 
# 导入数据
df <- read.csv("data/01_assignment_1_1_data.csv")
# 获取数据的行数和列数
df
dim(df)
# 绘制散点图
plot(df, main = "Scatter Plot", xlab = "X-Axis", ylab = "Y-Axis")

# 1-2
# 初始化一个变量，用于存储随机数向量的总和
sum <- 0
# 生成长度为 50 的随机数向量
random_vector <- runif(50)
# 循环累加随机数向量中的值
for (i in 1:50) {
  sum <- sum + random_vector[i]
}
# 计算平均值
mean_value <- sum / 50
# 输出随机数向量和随机数向量的平均值
random_vector
cat("随机数向量的平均值为:", mean_value)
