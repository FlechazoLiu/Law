/- 基础对象类定义文件 -/
import Law.Types.OwnerTypes
import Law.Types.PropertyTypes

/- 基础对象结构 -/
structure Object where
  id : String                  -- 唯一标识符
  name : String                -- 对象名称
  description : String := ""   -- 描述
  owner : Option OwnerType := none -- 所有者
  value : Nat := 0             -- 基础价值
  isLegal : Bool := true       -- 合法性标记
  isExclusive : Bool := false  -- 排他性标记（是否排除他人使用）
  createTime : String := ""    -- 创建时间
  updateTime : String := ""    -- 更新时间

/- 对象合法性检查 -/
def Object.checkLegal (obj : Object) : Bool :=
  obj.isLegal

/- 对象所有权检查 -/
def Object.hasOwner (obj : Object) : Bool :=
  obj.owner.isSome

/- 对象可以被认为是财产的条件 -/
def Object.canBeProperty (obj : Object) : Bool :=
  obj.hasOwner && obj.value > 0 && obj.isLegal

/- 对象标识更新 -/
def Object.updateId (obj : Object) (newId : String) : Object :=
  { obj with id := newId }

/- 对象所有权更新 -/
def Object.updateOwner (obj : Object) (newOwner : OwnerType) : Object :=
  { obj with
    owner := some newOwner,
    updateTime := "当前时间"  -- 在实际应用中应该使用系统时间
  }

/- 对象价值更新 -/
def Object.updateValue (obj : Object) (newValue : Nat) : Object :=
  { obj with
    value := newValue,
    updateTime := "当前时间"  -- 在实际应用中应该使用系统时间
  }

/- 对象排他性更新 -/
def Object.updateExclusivity (obj : Object) (isExclusive : Bool) : Object :=
  { obj with
    isExclusive := isExclusive,
    updateTime := "当前时间"  -- 在实际应用中应该使用系统时间
  }
