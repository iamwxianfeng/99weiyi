该文档是99weyi 类和表的简单定义
1. 问答助手的问题
```
class_name: Question
table_name: questions
id,
user_id, integer
size_type
up_size_id
down_size_id, integer
url, string
content, text
```

2. 量体师或管理员对用户问题的回复
```
class_name: Answer
table_name: answers
question_id, integer
user_id, integer
content,text
```

reserves： 预约表
id
address: 地址
name:  姓名
phone: 电话
service_time: 服务时间
experience_store:
type: 上门量体，上门定制，体验店定制
status:

代金券表
coupons

id
amount
end_time

用户代金券表
user_coupons
 id,
 user_id,
 coupons_id,
 status

邀请记录表
invitations
id,
status, #验证状态
user_id #邀请者id
invited_id: #被邀请者id
created_at #邀请时间

users:

birthday
invite_token
gender
province
city
phone
address
phone_verify
email_verify



passports

id
user_id
provider_uid  //visitor_id
provider_name //visitor_nick
avatar_url //avatar_src
is_actived //
actived_at



| user_id       | int(11)     | YES  |     | 0                   |                |
| provider_uid  | varchar(20) | YES  |     |                     |                |
| provider_name | varchar(20) | YES  |     |                     |                |
| avatar_url    | varchar(50) | YES  |     |                     |                |
| is_actived    | tinyint(1)  | YES  |     | 0                   |                |
| actived_at

provider,login
