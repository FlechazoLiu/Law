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
