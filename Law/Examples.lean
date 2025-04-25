/- 示例验证文件 -/
import Law.Legal

/- 示例验证 -/

-- 示例1：国有土地（自动识别为公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.State, "国有土地", 1000, PropertyPurpose.General, none, {}, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    trivial
  LegalProperty.public ⟨prop, proof⟩

-- 示例2：国家机关管理的公民财产（视为公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "扣押车辆", 50, PropertyPurpose.General, some ManagementInstitution.StateOrgan, { isManaged := true }, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    apply And.intro
    exact rfl
    apply Or.inr
    simp [isInSpecialState]
    trivial
  LegalProperty.public ⟨prop, proof⟩

-- 示例3：个体工商户合法财产（识别为私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.IndividualBusiness, "商铺设备", 20, PropertyPurpose.General, none, {}, none, none, none, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例4：用于扶贫的社会捐助财产（公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.SocialDonation, "扶贫基金", 5000, PropertyPurpose.PovertyAlleviation, none, {}, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    trivial
  LegalProperty.public ⟨prop, proof⟩

-- 示例5：公民合法储蓄（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "银行存款", 10000, PropertyPurpose.General, none, {}, some CitizenPropertyType.Savings, none, none, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    constructor
    trivial
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例6：家庭生产资料（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Family, "家庭作坊机器", 3000, PropertyPurpose.General, none, {}, none, some ResourceType.ProductionResources, none, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例7：个人股票（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "上市公司股票", 8000, PropertyPurpose.General, none, {}, none, none, some FinancialAsset.Stock, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    constructor
    trivial
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例8：公民委托代管物品（视为公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "委托代管物品", 500, PropertyPurpose.General, some ManagementInstitution.StateCompany, { isManaged := false, isUsed := true, isTransported := false }, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    apply And.intro
    exact rfl
    apply Or.inr
    simp [isInSpecialState]
    trivial
  LegalProperty.public ⟨prop, proof⟩

-- 示例9：公民工资收入（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "工资收入", 5000, PropertyPurpose.General, none, {}, some CitizenPropertyType.Income, none, none, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    constructor
    trivial
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例10：个人住宅（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "个人住宅", 2000000, PropertyPurpose.General, none, {}, some CitizenPropertyType.Housing, none, none, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    constructor
    trivial
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例11：教育专项基金（公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.SpecialFund, "教育专项基金", 10000, PropertyPurpose.PublicWelfare, none, {}, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    trivial
  LegalProperty.public ⟨prop, proof⟩

-- 示例12：私营企业财产（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.PrivateEnterprise, "公司办公设备", 50000, PropertyPurpose.General, none, {}, none, none, none, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例13：公民委托企业修理物品（视为公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "委托维修物品", 300, PropertyPurpose.General, some ManagementInstitution.CollectiveEnterprise, { isManaged := true }, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    apply And.intro
    exact rfl
    apply Or.inr
    simp [isInSpecialState]
    trivial
  LegalProperty.public ⟨prop, proof⟩

-- 示例14：家用电器（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "家用电器", 8000, PropertyPurpose.General, none, {}, some CitizenPropertyType.OtherLivingMaterials, none, none, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    constructor
    trivial
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例15：托运物品（视为公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "托运物品", 1000, PropertyPurpose.General, some ManagementInstitution.PeopleGroup, { isTransported := true }, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    apply And.intro
    exact rfl
    apply Or.inr
    simp [isInSpecialState]
    trivial
  LegalProperty.public ⟨prop, proof⟩

-- 示例16：班级集体财产（属于一种集体但不属于法条定义的劳动群众集体）
def classProperty : Property :=
  let classCollective : Collective := {
    baseType := CollectiveBaseType.Social,
    form := CollectiveForm.EducationalGroup,
    scale := CollectiveScale.Small,
    name := "高三一班",
    hasDefinedMembers := true,
    hasGovernance := true,
    hasCommonInterest := true,
    hasPropertyOwnership := true,
    formallyRecognized := true,
    legalStatusCode := none
  }
  {
    owner := OwnerType.Collective,
    assetName := "班费",
    value := 2000,
    purpose := PropertyPurpose.General,
    manager := none,
    state := {},
    citizenType := none,
    resourceType := none,
    financialType := none,
    collective := some classCollective,
    isLegal := true
  }

-- 示例17：国家债券（私有财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "国债", 10000, PropertyPurpose.General, none, {}, none, none, some FinancialAsset.Bond, none, true⟩
  let proof : isPrivateProperty prop := by
    simp [isPrivateProperty]
    constructor
    trivial
    trivial
  LegalProperty.private_property ⟨prop, proof⟩

-- 示例18：农村集体经济组织财产（符合法条定义的劳动群众集体）
def ruralCollectiveProperty : Property :=
  let ruralCollective : Collective := {
    baseType := CollectiveBaseType.Economic,
    form := CollectiveForm.RuralEconomic,
    scale := CollectiveScale.Medium,
    name := "某村民委员会",
    hasDefinedMembers := true,
    hasGovernance := true,
    hasCommonInterest := true,
    hasPropertyOwnership := true,
    formallyRecognized := true,
    legalStatusCode := none
  }
  {
    owner := OwnerType.Collective,
    assetName := "集体林地",
    value := 50000,
    purpose := PropertyPurpose.General,
    manager := none,
    state := {},
    citizenType := none,
    resourceType := none,
    financialType := none,
    collective := some ruralCollective,
    isLegal := true
  }

example : isPublicProperty ruralCollectiveProperty := by simp [isPublicProperty, isLegalCollective, ruralCollectiveProperty]

-- 新增示例19：国有公司管理的私人财产（视为公共财产）
example : LegalProperty :=
  let prop : Property := ⟨OwnerType.Citizen, "委托代管物品", 500, PropertyPurpose.General, some ManagementInstitution.StateCompany, { isUsed := true }, none, none, none, none, true⟩
  let proof : isPublicProperty prop := by
    simp [isPublicProperty]
    apply And.intro
    exact rfl
    apply Or.inl
    exact rfl
  LegalProperty.public ⟨prop, proof⟩

-- 新增示例20：职工集体经济组织财产（符合法条定义的劳动群众集体）
def workerCollectiveProperty : Property :=
  let cooperative : Collective := {
    baseType := CollectiveBaseType.Economic,
    form := CollectiveForm.WorkerEconomic,
    scale := CollectiveScale.Medium,
    name := "某厂职工集体",
    hasDefinedMembers := true,
    hasGovernance := true,
    hasCommonInterest := true,
    hasPropertyOwnership := true,
    formallyRecognized := true,
    legalStatusCode := none
  }
  {
    owner := OwnerType.Collective,
    assetName := "职工集体设备",
    value := 60000,
    purpose := PropertyPurpose.General,
    manager := none,
    state := {},
    citizenType := none,
    resourceType := none,
    financialType := none,
    collective := some cooperative,
    isLegal := true
  }

example : isPublicProperty workerCollectiveProperty := by simp [isPublicProperty, isLegalCollective, workerCollectiveProperty]
