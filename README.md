# XMLToOriginalo

根据xml动态生成原生控件

用到XMLReader对xml解析 和 MJExtension将数据转模型

XMLReader:
NSDictionary *xmldic = [XMLReader dictionaryForXMLData:xmlData error:&error];
将接收到的xml文件以NSData的形式进行解析,解析结果以NSDictionary的数据类型返回.
判断:
每个xml文件有几个表单:
    1.多个表单,
    2.单个表单,
每个表单有几个控件:
    1.多个控件,
    2.单个控件,
每个控件是否嵌套:
    1.嵌套多个控件,
    2.嵌套单个控件,
    3.嵌套多个数据,
    4.嵌套单个数据,

难点:
1.xml解析出来都会在外面包一层字典,
2.当某一层值包含一条数据时,会变为字典;包含多条数据时,会变为数组,需要针对两种情况进行分析

MJExtension:
小技巧:
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"model中的参数名" : @"数据中的参数名"};
}
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"model中的参数名" : @"类名"}
}
mj_replacedKeyFromPropertyName与mj_objectClassInArray配合食用口味更佳
先用mj_replacedKeyFromPropertyName将"请求到的数据中路径"与"model中的参数名"对应好,"请求到的数据中路径"如果包含数组或字典可以使用.或[index]来读取下级
再用mj_objectClassInArray将"model中的参数名"中的数据保存为对应"类名"的数据数组
