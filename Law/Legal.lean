/- 法律定义文件 -/
import Law.Property

/- 公共财产类型（第九十一条） -/
structure PublicProperty where
  prop : Property
  proof : isPublicProperty prop

/- 私有财产类型（第九十二条） -/
structure PrivateProperty where
  prop : Property
  proof : isPrivateProperty prop

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
def isPropertyRightsViolation (originalOwner : Property) (newState : Property) (violationType : PropertyRightsViolationType := PropertyRightsViolationType.Other) : Prop :=
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
