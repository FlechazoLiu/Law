/- 法律定义文件 -/
import Law.Property

/- 公共财产类型（第九十一条） -/
structure PublicProperty where
  prop : Property
  isPublic : isPublicProperty prop = true

/- 私有财产类型（第九十二条） -/
structure PrivateProperty where
  prop : Property
  isPrivate : isPrivateProperty prop = true

/- 法定财产类型定义 -/
inductive LegalProperty where
  | public (p : PublicProperty)  -- 公共财产构造器
  | private_property (p : PrivateProperty)  -- 私有财产构造器（避免关键字冲突）

/- 侵犯财产权类型 -/
inductive PropertyRightsViolationType where
  | Theft          -- 盗窃
  | Robbery        -- 抢劫
  | Fraud          -- 诈骗
  | Extortion      -- 敲诈勒索
  | Destruction    -- 破坏
  | IllegalSale    -- 非法买卖
  | IllegalSeizure -- 非法占有
  | Other          -- 其他侵犯形式
  deriving DecidableEq  -- 添加DecidableEq派生以支持==运算符

/- 侵犯财产权判定 -/
def isPropertyRightsViolation (originalOwner : Property) (newState : Property) (violationType : PropertyRightsViolationType := PropertyRightsViolationType.Other) : Bool :=
  -- 判断主要条件：
  -- 1. 财产所有者发生变更
  -- 2. 缺少合法变更依据
  -- 3. 无论公共财产还是私有财产，都受法律保护
  (
    -- 所有者变更且非法变更
    (originalOwner.owner ≠ newState.owner && !newState.isLegal)
    ||
    -- 即使所有者未变更，但财产状态非法变更或损害（如破坏）
    (violationType == PropertyRightsViolationType.Destruction && originalOwner.value > newState.value)
    ||
    -- 非法占有情形（即使不变更所有权）
    (violationType == PropertyRightsViolationType.IllegalSeizure &&
     originalOwner.owner = newState.owner && !newState.isLegal)
  )

/- 创建基本对象实例 -/
def createBasicObject (name : String) (id : String := "") : Object :=
  {
    id := if id = "" then s!"obj_{name}" else id,
    name := name,
    createTime := "当前时间" -- 实际应用中应使用系统时间
  }

/- 创建基本财产实例 -/
def createBasicProperty (obj : Object) (purpose : PropertyPurpose := PropertyPurpose.General) : Property :=
  createPropertyFromObject obj purpose

/- 将基本对象升级为公共财产 -/
def upgradeToPublicProperty (obj : Object) (ownerType : OwnerType := OwnerType.State) : Option PublicProperty :=
  -- 设置所有者
  let updatedObj := obj.updateOwner ownerType
  -- 转换为财产
  let prop := createPropertyFromObject updatedObj PropertyPurpose.PublicWelfare
  -- 检查是否满足公共财产条件
  if h : isPublicProperty prop then
    -- 使用命名的证明变量h，它有正确的类型：isPublicProperty prop = true
    some { prop := prop, isPublic := h }
  else
    none

/- 将基本对象升级为私有财产 -/
def upgradeToPrivateProperty (obj : Object) (ownerType : OwnerType := OwnerType.Citizen) : Option PrivateProperty :=
  -- 检查所有者类型是否为私有类型
  if ownerType ≠ OwnerType.Citizen &&
     ownerType ≠ OwnerType.Family &&
     ownerType ≠ OwnerType.IndividualBusiness &&
     ownerType ≠ OwnerType.PrivateEnterprise then
    none
  else
    -- 设置所有者
    let updatedObj := obj.updateOwner ownerType
    -- 转换为财产
    let prop := createPropertyFromObject updatedObj PropertyPurpose.General

    -- 根据所有者类型设置额外信息
    let finalProp := match ownerType with
      | OwnerType.Citizen =>
          { prop with citizenType := some CitizenPropertyType.OtherLivingMaterials }
      | OwnerType.Family =>
          { prop with resourceType := some ResourceType.ProductionResources }
      | _ => prop

    -- 检查是否满足私有财产条件
    if h : isPrivateProperty finalProp then
      -- 使用命名的证明变量h，它有正确的类型：isPrivateProperty finalProp = true
      some { prop := finalProp, isPrivate := h }
    else
      none
