前台功能模块：

裁缝列表（评论最多展示3条）
  头像
  昵称
  描述
  商圈区域
  评分
  预订数

评论列表：
  评论者昵称
  评论内容
  评论时间


裁缝筛选（按区域）市，区，商圈

商圈列表的获取

裁缝详情
头像
昵称
描述
商圈区域
服务范围
评分
预订数
服务时间
年龄
籍贯




裁缝的评论列表展示
对裁缝的评论打分
总评分值
照片（最多3张）
评价内容



下订单（定做衣服，免费量尺寸）在上次基础上做相应修改
联系人
电话
身高
体重
上门时间
我在（服务地址）
描述



后台模块：
裁缝管理
商圈管理（市－> 区－> 商圈，增删改）
评论管理 （查看）
预约订单处理


市表
bs_citys
id: int
name: string

区表
bs_districts
id:
name:

商圈表
bs_areas
id:
name:

裁缝表 和用户表，市，区，商圈表 关联
tailors
user_id
<!-- bs_citys_id
bs_districts_id
bs_areas_id -->
desc
desc_pic
score: int 评分
book_counts: int 预定数
bs_areas:商圈区域
scope: 服务范围
work_time: 服务时间 ? 一个范围，还是多个时间段




裁缝评论表
tailor_comments

has_many: pictures

tailor_id: int
user_id: int
content: text
score: int
created_at: datetime


