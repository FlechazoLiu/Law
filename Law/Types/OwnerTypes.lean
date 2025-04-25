/- 所有者类型定义文件 -/

/- 定义所有者类型 -/
inductive OwnerType where
  | State  -- 国家所有
  | Collective  -- 劳动群众集体所有
  | SocialDonation  -- 社会捐助
  | SpecialFund  -- 专项基金
  | Citizen  -- 公民个人
  | Family  -- 家庭所有
  | IndividualBusiness  -- 个体工商户
  | PrivateEnterprise  -- 私营企业
  deriving DecidableEq

/- 定义管理机构类型（第九十一条第二款） -/
inductive ManagementInstitution where
  | StateOrgan  -- 国家机关
  | StateCompany  -- 国有公司
  | StateEnterprise  -- 国有企业
  | CollectiveEnterprise  -- 集体企业
  | PeopleGroup  -- 人民团体
  deriving DecidableEq
