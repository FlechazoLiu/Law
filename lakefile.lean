import Lake
open Lake DSL

package «Law» where
  -- add package configuration options here

@[default_target]
lean_lib «Law» where
  -- add library configuration options here

-- require mathlib from git
--   "https://github.com/leanprover-community/mathlib4.git" @ "v4.10.0"


require «doc-gen4» from git "https://github.com/leanprover/doc-gen4" @ "v4.16.0"
