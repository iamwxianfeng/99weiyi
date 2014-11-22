Api 接口地址：

* 测试环境：http://99weiyi.com:9001/
* 线上环境：http://www.99weiyi.com/

1. 获取身高json 数据

```
GET /v1/heights
Parameters:
{
  access_token // 用户唯一标识，String 必选
}

eg: http:/365weiyi.com:9001/v1/heights?access_token=7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6

Status 200
Response:

[{"id": 1,"value": 155 }, ...]

```
2. 获取体重json 数据

```
GET /v1/weights
Status 200
Response:

[{"id": 1,"value": 48 }, ...]

```
3. 用户输入性别,身高,体重,喜好,获取预估尺寸

```
POST /v1/my/forecast
Input:
{
  gende: 1, // 性别 Int 必选 0 男，1 女
  height： 9 // height_id: 150cm
  weight： 2 // weight_id: 50kg
  style： "loose" // loose: 宽松 normal: 正常 fit: 合适 tight: 紧身
}
Response:
Success: Status 200 OK

{
	chest: "90.4" //胸围
	middle_chest: "80.4" //中腰围
	shoulder: "41.0" //肩宽
	sleeve: "56.0" //袖长
	neck: "36.0"  //领围
	down_chest: "82.4" //腰围
	ass: "93.0" //臀围
	crosspiece: "53.6" // 横档
	foot: "98.0" //脚长
	access_token: "7a68b4d65ddd6a6191ef0cbf9cadb06528d92d6" // 客户端保存token，每次请求带上该token
}

失败返回: Status 422
{"message":  "抱歉，您选择的身高和体重没有预估尺寸，您可以重新选择"}
```
4. 自己量尺寸

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
	ass: 98 //臀围
	crosspiece: 54 //横档
	foot: 99 //脚长
	knee: 23 //膝围
}
Response:
Success: Status 200 OK
```
5. 查看各类型服饰尺码


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
6. 问助手

```
POST /v1/questions
eg: http://99weiyi.com:9001/v1/questions?access_token=d2sefesfe09dss30dkl2ds
//该接口 传上衣类型ID 或下衣类型ID，两个只能选择一个类型 
输入参数:
{
	up_size_id: 1 // 上衣服装类型
	down_size_id: 2 //下衣服装类型
	url: "www.abc.com"// 服装产品网址,可不填
	content: "提问内容" //验证不超过200字
}
返回结果:
Status 201 OK

```