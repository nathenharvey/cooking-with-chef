name "base_ubuntu"
description "Attributes and recipes for all Ubuntu servers"
run_list(
  "recipe[apt]",
  "recipe[build-essential]"
) 
