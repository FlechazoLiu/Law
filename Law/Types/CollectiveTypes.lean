/- 集体类型定义文件 -/
import Law.Types.OwnerTypes

/- 集体类型基础分类 -/
inductive CollectiveBaseType where
  | Economic  -- 经济性集体
  | Social    -- 社会性集体
  | Political -- 政治性集体
  | Cultural  -- 文化性集体
  | Religious -- 宗教性集体
  | Temporary -- 临时性集体
  deriving DecidableEq

/- 集体组织形式 -/
inductive CollectiveForm where
  | RuralEconomic      -- 农村集体经济组织
  | UrbanEconomic      -- 城镇集体经济组织
  | WorkerEconomic     -- 职工集体经济组织
  | EducationalGroup   -- 教育群体（班级、学校、教研组）
  | SocialAssociation  -- 社会团体（协会、俱乐部）
  | ProfessionalOrg    -- 专业组织（行业协会、学会）
  | Cooperative        -- 合作社
  | ResidentGroup      -- 居民组织（小区业主委员会）
  | Charity            -- 慈善组织
  | SpecialPurpose     -- 特定目的集体（项目组、活动组）
  | Other              -- 其他集体形式
  deriving DecidableEq

/- 集体规模分类 -/
inductive CollectiveScale where
  | Small   -- 小型集体（如班级）
  | Medium  -- 中型集体（如社区）
  | Large   -- 大型集体（如大型企业职工集体）
  deriving DecidableEq

/- 综合集体定义 -/
structure Collective where
  baseType : CollectiveBaseType                  -- 基础类型
  form : CollectiveForm                          -- 组织形式
  scale : CollectiveScale                        -- 规模
  name : String                                  -- 集体名称
  legalStatusCode : Option String := none        -- 法律地位代码（如有）
  hasDefinedMembers : Bool := true               -- 是否有明确成员范围
  hasGovernance : Bool := true                   -- 是否有治理结构
  hasCommonInterest : Bool := true               -- 是否有共同利益
  hasPropertyOwnership : Bool := true            -- 是否有共同财产所有权
  formallyRecognized : Bool := true              -- 是否得到正式认可

/- 判断集体是否为法律认可的劳动群众集体 -/
def isLegalCollective (c : Collective) : Bool :=
  c.formallyRecognized &&
  (match c.form with
   | CollectiveForm.RuralEconomic => true
   | CollectiveForm.UrbanEconomic => true
   | CollectiveForm.WorkerEconomic => true
   | CollectiveForm.Cooperative => true
   | _ => false)
