/- 财产类型定义文件 -/

/- 定义财产用途类型 -/
inductive PropertyPurpose where
  | PovertyAlleviation  -- 扶贫
  | PublicWelfare  -- 其他公益事业
  | General  -- 一般用途
  deriving DecidableEq

/- 定义财产状态（第九十一条第二款） -/
structure PropertyState where
  isManaged : Bool := false  -- 管理中
  isUsed : Bool := false  -- 使用中
  isTransported : Bool := false  -- 运输中

/- 定义公民私人财产类型（第九十二条第一款） -/
inductive CitizenPropertyType where
  | Income  -- 合法收入
  | Savings  -- 储蓄
  | Housing  -- 房屋
  | OtherLivingMaterials  -- 其他生活资料
  deriving DecidableEq

/- 定义资源类型 -/
inductive ResourceType where
  | LivingResources  -- 生活资料
  | ProductionResources  -- 生产资料
  deriving DecidableEq

/- 定义金融资产类型（第九十二条第四款） -/
inductive FinancialAsset where
  | Share  -- 股份
  | Stock  -- 股票
  | Bond  -- 债券
  | Other  -- 其他财产
  deriving DecidableEq
