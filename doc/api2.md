Api 接口地址：

* 测试环境：http://chima.365weiyi.com/
* 线上环境：http://www.99weiyi.com/

### 用户输入性别,身高,体重,喜好,获取预估尺寸

```
POST /v1/my/forecast
Input:
{
  gender: 1, // 性别 Int 必选 0 男，1 女
  height： 9 // height_id: 150cm
  weight： 2 // weight_id: 50kg
  style： "loose" // loose: 宽松 normal: 正常 fit: 合适 tight: 紧身
  birthday: "1970-09-10" // 出生年月
}
Response:
Success: Status 200 OK

{
  weight： 65kg，//体重
  height： 179cm ，// 身高
  chest: "90.4" //胸围
  middle_chest: "80.4" //中腰围
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
  neck: "36.0"  //领围
  down_chest: "82.4" //腰围
  ass: "93.0" //臀围
  crosspiece: "53.6" // 横档
  foot: "98.0" //脚长
}
失败返回: Status 422
{"message":  "抱歉，您选择的身高和体重没有预估尺寸，您可以重新选择"}

```
### 保存自己量尺寸（用户注册后，才可保存自己量尺寸）

```
POST /v1/my/actual_size?access_token=7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6
Input:

{
  chest: 91 //胸围
  middle_chest: 82 //中腰围
  shoulder: 42 //肩宽
  sleeve: 57 //袖长
  neck: 37 //领围
  arm: 42 //臂围
  wrist: 24 //腕围
  zongdang: 34//总挡
  ass: 98 //臀围
  crosspiece: 54 //横档
  foot: 99 //脚长
  knee: 23 //膝围

}
Response:
Success: Status 200 OK
```

### 注册：

```
post /v1/users/signup?access_token=...
Input:
{
  email: '99@weiyi.com',
  password: '123456',
  password_confirm: '123456'
}

Response:
Success: Status 201 OK
{ access_token: '7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6' }
Error: Status 422
{
  "error":{
    "email":[
    "email\u5df2\u7ecf\u5b58\u5728"
   ]
  }
}

```
### 登录

```

post /v1/users/signin
Input:
{
  email: '99@weiyi.com',
  password: '123456'
}
Response:
Success: Status 200 OK
{ access_token: '7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6' }
Error: Status 401
{error: '用户名或密码错误'}

```

### 第三方登录

说明：客户端用第三方sdk 访问去weibo，qq 获取 access_token, uid,参数，再请求此接口
```
post /v1/users/oauth
uid: '1404376560' //需要查询的用户ID
provider：'qq｜weibo'
access_token // OAuth授权方式为必填参数,

Response:
Success: Status 200 OK
{access_token: '7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6'}
Error: Status 422
{error: '授权失败'}
```

<!-- ### 退出

```
delete /v1/users/signout?access_token=...

Response: Status 204 No content
``` -->

### 个人资料

```
get /v1/user?access_token=...

Response: Status 200 OK
{
  login: 'zhangsanfeng'
  gender: 1 # 0: 未知 1：男 2:女
  height： 9 // height_id: 150cm
  weight： 2 // weight_id: 50kg
  style: 'normal'
  province: 100000 #北京
  city: 100001 #朝阳
  weibo: {nick_name:'love xiaotiantian',activated: false},
  qq: {nick_name:'love xiaotiantian',activated: true},
  weixin: {nick_name:'love xiaotiantian',activated: true}
  avatar_url: http://upyun.com/xxx.png
}
```

### 编辑个人资料
```
patch: /v1/user?access_token=...
{
  login: 'zhangsanfeng'
  gender: 1 # 0: 未知 1：男 2:女
  height_id： 9 // height_id: 150cm
  weight_id： 2 // weight_id: 50kg
  style: 'normal'
  province: 100000 #北京
  city: 100001 #朝阳
}
Response: Status 200 OK

```
### 上传头像

```
post /v1/users/avatar?access_token=...
{
  file: #文件对象
}

Response: Status 200 OK
{
  avatar_url: http://upyun.com/xxx.png
}
```
### 预约

```
包括预约： 上门量体，上门定制，体验店
post /v1/reserves
Input: {
  address: "海淀区黄金小区4号楼5单元"//地址
  name:  "张无忌"//姓名
  phone: "13422345099"//电话
  service_time: '2014-7-30 13:23:23'//服务时间|到点时间
  shop_id: 2, //"朝阳区大望路店"// 体验店地址
  reserve_type: 1：上门量体，2：上门定制，3: 体验店定制
}
Response: Status 201 OK
{
  address: "海淀区黄金小区4号楼5单元"//地址
  name:  "张无忌"//姓名
  phone: "13422345099"//电话
  service_time: '2014-7-30 13:23:23'//服务时间|到点时间
  shop: '朝阳区大望路店'//
  reserve_type: 1：上门量体，2：上门定制，3: 体验店定制 //预约类型
}
```

###我的预约信息

```
get /v1/user/reserves?access_token=...

[
  {
    id: 1,
    address: "海淀区黄金小区4号楼5单元"//地址
    name:  "张无忌"//姓名
    phone: "13422345099"//电话
    service_time: '2014-7-30 13:23:23'//服务时间|到点时间
    shop: '朝阳区大望路店'//
    type: "上门定制"
    created_at: '2014-08-04T13:41:24Z'
  }
  {
    id:2,
    address: "海淀区黄金小区4号楼5单元"//地址
    name:  "张无忌"//姓名
    phone: "13422345099"//电话
    service_time: '2014-7-30 13:23:23'//服务时间|到点时间
    shop: '朝阳区大望路店'//
    reserve_type: "到点体验"
    created_at: '2014-08-04T13:41:24Z'
  }
]

```
### 我的代金券

```
get /v1/user/coupons?access_token=...
Response:

[
  { total: 10, amount: 300.00 }, //现金券总数
  { used: 7，amount: 210.00 }, //已使用
  { not_used: 3, amount: 90.000 } //未使用
]
```

### 我的互动

```
get /v1/user/interactions?access_token=...
Response:
{
  reserves: 3, //我的预约数
  invite: 5, //我的邀请数
  coupons: 5 //我的现金券张数
}
```

### 我的邀请记录

```
get /v1/user/invitations
{
  id:1,
  status: 0, #验证状态 #0：未验证， 1： 已验证
  invite_name: #被邀请者 #
  created_at #邀请时间
}
```

### 发送邀请

```
post /v1/invitations?access_token=...
Input:
{
  type: 'phone|email' #通讯录邀请，手机邀请
  value: '13439088184|jdd@weiyi.com'
}
Response: Status 200 OK

```
### 查看各类型服饰尺码（穿多大）

```
GET /v1/chima
参数:{
  type: "xifu"//服饰类型
  style: "lose",// normal,fit,tight,不带style参数默认请求normal 数据
  access_token: "7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6"
}
请求示例(查看西服的修身尺寸)：http://localhost:3000/v1/chima?type=xifu&style=tight&access_token=7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6
请求的类型不同，返回的数据不同,


type: 'xifu' //西服
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5"//下摆
  front_length: "71"//前长
  back_length: "68"//后长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'dressshirt' //正装衬衫
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5"//下摆
  length: "71"//前长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
  nick: "36.0" //领围
  wrist: "7.0" //腕围
  short_length: "32.0" //短袖长
}

type: 'casualshirt' //休闲衬衫
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5" //下摆
  length: "71" //前长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
  nick: "36.0" //领围
  wrist: "7.0" //腕围
  short_length: "32.0" //短袖长
}

type: 'tshirt' //T恤
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  length: "90" //衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'polo' //POLO衫
返回数据示例:
{
  chest: "90.4" //胸围
  length: "71" //衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'downcote' //羽绒服
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5" //下摆
  length: "60-86"//衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长00
}

type: 'jack' // 夹克
返回数据示例:
{
  chest: "90.4" //胸围
  length: "60-86"//衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'coat' // 外套
返回数据示例:
{
  chest: "90.4" //胸围
  length: "60-86" //衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'overcote' //大衣
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5" //下摆
  length: "71" //衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'sweater' //毛衣、针织衫、卫衣
返回数据示例:
{
  chest: "90.4" //胸围
  xiabai: "98.5" //下摆
  length: "71" //衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'dustcote'  //风衣
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5" //下摆
  length: "71" //衣长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'suncote' //中山装
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5" //下摆
  front_length: "71" //前长
  back_length: "68" //后长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'standcote' //立领
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5" //下摆
  front_length: "71" //前长
  back_length: "68" //后长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'tangcote' //唐装
返回数据示例:
{
  chest: "90.4" //胸围
  middle_chest: "80.4" //腰围
  xiabai: "98.5" //下摆
  front_length: "71" //前长
  back_length: "68" //后长
  shoulder: "41.0" //肩宽
  sleeve: "56.0" //袖长
}

type: 'xiku' //西裤
返回数据示例:
{
  down_chest: "80.4" //腰围
  ass: "97.5" //臀围
  zongdang: "61" // 总裆
  hengdang: "60.0" //横裆
  foot: "98.0" //裤长
  kukou："20" //裤口
}

```
