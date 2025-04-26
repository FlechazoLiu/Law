/- 示例文件，展示Object和Property的继承关系使用 -/
import Law.Legal

namespace Examples

/- 创建简单对象示例 -/
def createExampleObjects : IO Unit := do
  -- 创建基本对象
  let basicObj := createBasicObject "普通物品"
  IO.println s!"基本对象: {basicObj.name}, 是否有所有者: {basicObj.hasOwner}"

  -- 更新对象属性
  let updatedObj := { basicObj with
    value := 1000,
    description := "这是一个示例物品"
  }
  IO.println s!"更新后的对象: {updatedObj.name}, 价值: {updatedObj.value}"

  -- 检查是否可以成为财产
  IO.println s!"此对象是否可以成为财产: {updatedObj.canBeProperty}"

  -- 添加所有者，使其可以成为财产
  let ownedObj := updatedObj.updateOwner OwnerType.State
  IO.println s!"添加所有者后，是否可以成为财产: {ownedObj.canBeProperty}"

  return ()

/- 创建财产示例 -/
def createExampleProperties : IO Unit := do
  -- 创建公共财产
  let stateObj := createBasicObject "国有土地"
    |> (λ obj => obj.updateValue 10000000)
    |> (λ obj => obj.updateOwner OwnerType.State)

  match upgradeToPublicProperty stateObj with
  | some publicProp =>
      IO.println s!"成功创建公共财产: {publicProp.prop.name}"
      -- 公共财产判定
      let isPublic : Bool := isPublicProperty publicProp.prop
      IO.println s!"是否为公共财产: {isPublic}"
  | none => IO.println "创建公共财产失败"

  -- 创建私有财产
  let privateObj := createBasicObject "个人住宅"
    |> (λ obj => obj.updateValue 2000000)

  match upgradeToPrivateProperty privateObj OwnerType.Citizen with
  | some privateProp =>
      IO.println s!"成功创建私有财产: {privateProp.prop.name}"
      -- 私有财产判定
      let isPrivate : Bool := isPrivateProperty privateProp.prop
      IO.println s!"是否为私有财产: {isPrivate}"
  | none => IO.println "创建私有财产失败"

  return ()

/- 展示财产权利侵犯判定 -/
def demonstratePropertyViolation : IO Unit := do
  -- 创建原始状态的财产
  let originalObj := createBasicObject "珍贵物品"
    |> (λ obj => obj.updateValue 50000)
    |> (λ obj => obj.updateOwner OwnerType.Citizen)

  let originalProp := createPropertyFromObject originalObj

  -- 创建被侵犯后的状态
  let violatedObj := originalObj.updateOwner OwnerType.IndividualBusiness
  let violatedProp := {
    toObject := { violatedObj with isLegal := false },
    citizenType := some CitizenPropertyType.OtherLivingMaterials
  }

  -- 判断是否发生侵犯
  let isViolated : Bool := isPropertyRightsViolation originalProp violatedProp
                             PropertyRightsViolationType.Theft

  IO.println s!"财产所有权是否被侵犯: {isViolated}"

  return ()

/- 展示财产排他性 -/
def demonstrateExclusivity : IO Unit := do
  -- 创建普通对象
  let basicObj := createBasicObject "普通物品"
  IO.println s!"普通对象的排他性: {basicObj.isExclusive}"

  -- 创建并升级为财产对象
  let propertyObj := basicObj
    |> (λ obj => obj.updateValue 5000)
    |> (λ obj => obj.updateOwner OwnerType.Citizen)

  let property := createPropertyFromObject propertyObj
  IO.println s!"财产对象的排他性: {property.isExclusive}"

  -- 演示排他性更新
  let updatedObj := basicObj.updateExclusivity true
  IO.println s!"手动更新排他性后: {updatedObj.isExclusive}"

  return ()

/- 运行所有示例 -/
def runAllExamples : IO Unit := do
  IO.println "=== 对象示例 ==="
  createExampleObjects

  IO.println "\n=== 财产示例 ==="
  createExampleProperties

  IO.println "\n=== 财产权利侵犯示例 ==="
  demonstratePropertyViolation

  IO.println "\n=== 财产排他性示例 ==="
  demonstrateExclusivity

  return ()

end Examples

/- 主函数 -/
def examplesMain : IO Unit :=
  Examples.runAllExamples
