/- 刑法财产相关条款形式化 -/

/-
本项目实现了《刑法》第九十一条和第九十二条的形式化
第九十一条【公共财产的含义】本法所称公共财产，是指下列财产：
（一）国有财产；
（二）劳动群众集体所有的财产；
（三）用于扶贫和其他公益事业的社会捐助或者专项基金的财产。
在国家机关、国有公司、企业、集体企业和人民团体管理、使用或者运输中的私人财产，以公共财产论。

第九十二条【私人所有财产的含义】本法所称公民私人所有的财产，是指下列财产：
（一）公民的合法收入、储蓄、房屋和其他生活资料；
（二）依法归个人、家庭所有的生产资料；
（三）个体户和私营企业的合法财产；
（四）依法归个人所有的股份、股票、债券和其他财产。
-/

import Law.Types.OwnerTypes
import Law.Types.PropertyTypes
import Law.Types.CollectiveTypes
import Law.Property
import Law.Legal
import Law.Examples

/- 项目文件结构说明:
   1. Law.Types.OwnerTypes - 所有者类型定义
   2. Law.Types.PropertyTypes - 财产类型定义
   3. Law.Types.CollectiveTypes - 集体类型定义
   4. Law.Property - 财产结构和财产相关函数
   5. Law.Legal - 法律判定和法定财产类型
   6. Law.Examples - 示例验证
-/
