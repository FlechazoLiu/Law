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

/- 侵犯财产权判定 -/
def isPropertyRightsViolation (originalOwner : Property) (newState : Property) : Prop :=
  -- 财产所有者变更且未经合法程序
  originalOwner.owner ≠ newState.owner &&
  -- 缺少合法变更依据
  !newState.isLegal
