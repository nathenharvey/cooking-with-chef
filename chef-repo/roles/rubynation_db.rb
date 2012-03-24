name "rubynation_db"
description "Attributes and recipes for Rubynation Database nodes"
run_list(
  "recipe[database]",
  "recipe[mysql::server]",
  "recipe[rubynation::db]"
) 
