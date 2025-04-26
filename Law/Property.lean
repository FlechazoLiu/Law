/- 财产定义文件 -/
import Law.Types.OwnerTypes
import Law.Types.PropertyTypes
import Law.Types.CollectiveTypes
import Law.Object

/- 财产结构（扩展自Object） -/
structure Property extends Object where
  purpose : PropertyPurpose := PropertyPurpose.General  -- 财产用途
  manager : Option ManagementInstitution := none  -- 管理机构
  state : PropertyState := {}  -- 财产状态
  citizenType : Option CitizenPropertyType := none  -- 公民财产类型
  resourceType : Option ResourceType := none  -- 资源类型
  financialType : Option FinancialAsset := none  -- 金融资产类型
  collective : Option Collective := none  -- 集体详细信息

/- 从普通对象创建财产 -/
def createPropertyFromObject (obj : Object) (purpose : PropertyPurpose := PropertyPurpose.General) : Property :=
  if obj.canBeProperty then
    {
      toObject := {
        obj with
        isExclusive := true  -- 所有财产对象的排他性均为真
      },  -- 继承Object的所有字段
      purpose := purpose
    }
  else
    {
      toObject := {
        obj with
        isLegal := false,  -- 如果不满足财产条件，标记为非法
        isExclusive := true  -- 所有财产对象的排他性均为真
      },
      purpose := purpose
    }

/- 判断财产是否处于管理、使用或运输状态 -/
def isInSpecialState (p : Property) : Bool :=
  p.state.isManaged || p.state.isUsed || p.state.isTransported

/- 检查所有者是否为私人 -/
def isPrivateOwnerType (ownerOpt : Option OwnerType) : Bool :=
  match ownerOpt with
  | some OwnerType.Citizen => true
  | some OwnerType.Family => true
  | some OwnerType.IndividualBusiness => true
  | some OwnerType.PrivateEnterprise => true
  | _ => false

/- 判断财产是否为托管财产（辅助方法，但实际分类为公共财产） -/
def isInTrust (p : Property) : Bool :=
  isPrivateOwnerType p.owner &&
  p.isLegal &&
  (p.manager.isSome || isInSpecialState p)

/- 判断管理机构是否属于第91条第二款规定的特定机构 -/
def isSpecialManagementInstitution (manager : Option ManagementInstitution) : Bool :=
  match manager with
  | some ManagementInstitution.StateOrgan => true           -- 国家机关
  | some ManagementInstitution.StateCompany => true         -- 国有公司
  | some ManagementInstitution.StateEnterprise => true      -- 国有企业
  | some ManagementInstitution.CollectiveEnterprise => true -- 集体企业
  | some ManagementInstitution.PeopleGroup => true          -- 人民团体
  | _ => false

/- 公共财产判定（第九十一条） -/
def isPublicProperty (p : Property) : Bool :=
  match p.owner with
  | some OwnerType.State => true  -- 国有财产（第九十一条第一款第一项）
  | some OwnerType.Collective =>
    -- 劳动群众集体所有的财产（第九十一条第一款第二项）
    -- 检查是否为合法认可的集体
    match p.collective with
    | some c => isLegalCollective c
    | none => false
  | some OwnerType.SocialDonation =>
    -- 用于扶贫和其他公益事业的社会捐助（第九十一条第一款第三项）
    p.purpose = PropertyPurpose.PovertyAlleviation || p.purpose = PropertyPurpose.PublicWelfare
  | some OwnerType.SpecialFund =>
    -- 用于扶贫和其他公益事业的专项基金（第九十一条第一款第三项）
    p.purpose = PropertyPurpose.PovertyAlleviation || p.purpose = PropertyPurpose.PublicWelfare
  | some _ =>
    -- 在国家机关、国有公司、企业、集体企业和人民团体管理、使用或者运输中的私人财产，以公共财产论（第九十一条第二款）
    isPrivateOwnerType p.owner &&
    p.isLegal &&
    (isSpecialManagementInstitution p.manager || isInSpecialState p)
  | none => false

/- 私有财产判定（第九十二条） -/
def isPrivateProperty (p : Property) : Bool :=
  match p.owner with
  | some OwnerType.Citizen =>
    p.isLegal && (
      -- 公民的合法收入、储蓄、房屋和其他生活资料（第九十二条第一项）
      (match p.citizenType with
       | some CitizenPropertyType.Income => true            -- 合法收入
       | some CitizenPropertyType.Savings => true           -- 储蓄
       | some CitizenPropertyType.Housing => true           -- 房屋
       | some CitizenPropertyType.OtherLivingMaterials => true  -- 其他生活资料
       | none => false) ||
      -- 生活资料也算入第一项
      (p.resourceType = some ResourceType.LivingResources) ||
      -- 依法归个人所有的股份、股票、债券和其他财产（第九十二条第四项）
      (match p.financialType with
       | some FinancialAsset.Share => true  -- 股份
       | some FinancialAsset.Stock => true  -- 股票
       | some FinancialAsset.Bond => true   -- 债券
       | some FinancialAsset.Other => true  -- 其他财产
       | none => false)
    )
  | some OwnerType.Family =>
    -- 依法归个人、家庭所有的生产资料（第九十二条第二项）
    p.isLegal && p.resourceType = some ResourceType.ProductionResources
  | some OwnerType.IndividualBusiness =>
    -- 个体户的合法财产（第九十二条第三项）
    p.isLegal
  | some OwnerType.PrivateEnterprise =>
    -- 私营企业的合法财产（第九十二条第三项）
    p.isLegal
  | _ => false
