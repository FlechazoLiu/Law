/- 法律定义文件 -/
import Law.Property

/- 法定财产类型定义 -/
inductive LegalProperty where
  | public (p : Property) (h : isPublicProperty p)  -- 公共财产构造器
  | private_property (p : Property) (h : isPrivateProperty p)  -- 私有财产构造器（避免关键字冲突）

/- 侵犯财产权判定 -/
def isPropertyRightsViolation (originalOwner : Property) (newState : Property) : Prop :=
  -- 财产所有者变更且未经合法程序
  originalOwner.owner ≠ newState.owner &&
  -- 缺少合法变更依据
  !newState.isLegal

-- 法条形式化：刑法91、92条关于财产定义

-- 财产用途枚举
inductive PropertyPurpose
  | General            -- 一般用途
  | PovertyAlleviation -- 扶贫
  | PublicWelfare      -- 公益事业
  | Other              -- 其他用途

-- 财产所有者类型
inductive OwnerType
  | State              -- 国家
  | Collective         -- 集体
  | Citizen            -- 公民个人
  | Family             -- 家庭
  | IndividualBusiness -- 个体户
  | PrivateEnterprise  -- 私营企业
  | SocialDonation     -- 社会捐助
  | SpecialFund        -- 专项基金

-- 公民财产类型
inductive CitizenPropertyType
  | Income         -- 合法收入
  | Savings        -- 储蓄
  | Housing        -- 房屋
  | LivingMaterials -- 其他生活资料

-- 资源类型
inductive ResourceType
  | ProductionResources -- 生产资料
  | ConsumptionResources -- 消费资料

-- 金融资产类型
inductive FinancialAsset
  | Stock  -- 股票
  | Share  -- 股份
  | Bond   -- 债券
  | Other  -- 其他金融资产

-- 管理机构类型
inductive ManagementInstitution
  | StateOrgan           -- 国家机关
  | StateOwnedCompany    -- 国有公司
  | StateOwnedEnterprise -- 国有企业
  | CollectiveEnterprise -- 集体企业
  | PeopleOrganization   -- 人民团体

-- 集体基础类型
inductive CollectiveBaseType
  | Economic -- 经济性质集体
  | Social   -- 社会性质集体

-- 集体形式
inductive CollectiveForm
  | RuralEconomic   -- 农村经济组织
  | UrbanEconomic   -- 城镇经济组织
  | LaborGroup      -- 其他劳动群众集体
  | EducationalGroup -- 教育类集体
  | Other            -- 其他集体

-- 集体规模
inductive CollectiveScale
  | Small
  | Medium
  | Large

-- 集体结构
structure Collective where
  baseType : CollectiveBaseType
  form : CollectiveForm
  scale : CollectiveScale
  name : String
  hasDefinedMembers : Bool
  hasGovernance : Bool
  hasCommonInterest : Bool
  hasPropertyOwnership : Bool
  formallyRecognized : Bool
  legalStatusCode : Option String

-- 财产状态
structure PropertyState where
  isManaged : Bool := false
  isInUse : Bool := false
  isInTransit : Bool := false

-- 财产基本结构
structure Property where
  owner : OwnerType
  assetName : String
  value : Nat
  purpose : PropertyPurpose
  managedBy : Option ManagementInstitution := none
  state : PropertyState := {}
  citizenPropertyType : Option CitizenPropertyType := none
  resourceType : Option ResourceType := none
  financialAsset : Option FinancialAsset := none
  collective : Option Collective := none
  isLegal : Bool

-- 判断是否为符合法条定义的劳动群众集体
def isLegalCollective (c : Collective) : Prop :=
  c.baseType = CollectiveBaseType.Economic &&
  (c.form = CollectiveForm.RuralEconomic ||
   c.form = CollectiveForm.UrbanEconomic ||
   c.form = CollectiveForm.LaborGroup) &&
  c.hasDefinedMembers &&
  c.hasPropertyOwnership

-- 判断是否处于特殊状态（在国家机关、国有公司、企业、集体企业和人民团体管理、使用或者运输中）
def isInSpecialState (prop : Property) : Prop :=
  match prop.managedBy with
  | some ManagementInstitution.StateOrgan => prop.state.isManaged || prop.state.isInUse || prop.state.isInTransit
  | some ManagementInstitution.StateOwnedCompany => prop.state.isManaged || prop.state.isInUse || prop.state.isInTransit
  | some ManagementInstitution.StateOwnedEnterprise => prop.state.isManaged || prop.state.isInUse || prop.state.isInTransit
  | some ManagementInstitution.CollectiveEnterprise => prop.state.isManaged || prop.state.isInUse || prop.state.isInTransit
  | some ManagementInstitution.PeopleOrganization => prop.state.isManaged || prop.state.isInUse || prop.state.isInTransit
  | _ => false

-- 判断是否为公共财产（刑法第91条）
def isPublicProperty (prop : Property) : Prop :=
  -- 第91条第一款（一）：国有财产
  prop.owner = OwnerType.State ||
  -- 第91条第一款（二）：劳动群众集体所有的财产
  (prop.owner = OwnerType.Collective &&
   match prop.collective with
   | some c => isLegalCollective c
   | none => false) ||
  -- 第91条第一款（三）：用于扶贫和其他公益事业的社会捐助或者专项基金的财产
  (prop.owner = OwnerType.SocialDonation &&
   (prop.purpose = PropertyPurpose.PovertyAlleviation ||
    prop.purpose = PropertyPurpose.PublicWelfare)) ||
  (prop.owner = OwnerType.SpecialFund &&
   (prop.purpose = PropertyPurpose.PovertyAlleviation ||
    prop.purpose = PropertyPurpose.PublicWelfare)) ||
  -- 第91条第二款：在国家机关、国有公司、企业、集体企业和人民团体管理、使用或者运输中的私人财产
  isInSpecialState prop

-- 判断是否为私人财产（刑法第92条）
def isPrivateProperty (prop : Property) : Prop :=
  -- 基本条件：合法且不是公共财产
  prop.isLegal &&
  ¬(isPublicProperty prop) &&
  (
    -- 第92条（一）：公民的合法收入、储蓄、房屋和其他生活资料
    (prop.owner = OwnerType.Citizen &&
     (match prop.citizenPropertyType with
      | some CitizenPropertyType.Income => true
      | some CitizenPropertyType.Savings => true
      | some CitizenPropertyType.Housing => true
      | some CitizenPropertyType.LivingMaterials => true
      | _ => false)) ||

    -- 第92条（二）：依法归个人、家庭所有的生产资料
    ((prop.owner = OwnerType.Citizen || prop.owner = OwnerType.Family) &&
     match prop.resourceType with
     | some ResourceType.ProductionResources => true
     | _ => false) ||

    -- 第92条（三）：个体户和私营企业的合法财产
    (prop.owner = OwnerType.IndividualBusiness || prop.owner = OwnerType.PrivateEnterprise) ||

    -- 第92条（四）：依法归个人所有的股份、股票、债券和其他财产
    (prop.owner = OwnerType.Citizen &&
     match prop.financialAsset with
     | some _ => true
     | _ => false)
  )
