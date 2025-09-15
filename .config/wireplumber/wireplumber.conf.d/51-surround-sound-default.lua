rule = {
  matches = {
    {
      { "node.name", "equals", "effect_input.virtual-surround-7.1" },
    },
  },
  apply_properties = {
    ["node.default"] = true,
  },
}

table.insert(alsa_monitor.rules, rule)
