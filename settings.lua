data:extend({
  {
    name = "resource-refill-ore-enabled",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "a"
  },
  {
    name = "resource-refill-amount-ore",
    type = "int-setting",
    setting_type = "runtime-global",
    default_value = 5000,
    order = "b"
  },
  {
    name = "resource-refill-oil-enabled",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "c"
  },
  {
    name = "resource-refill-amount-oil",
    type = "int-setting",
    setting_type = "runtime-global",
    default_value = 100,
    order = "d"
  },
  {
    name = "resource-refill-interval-oil",
    type = "int-setting",
    setting_type = "runtime-global",
    default_value = 300,
    minimum_value = 5,
    order = "e"
  },
});