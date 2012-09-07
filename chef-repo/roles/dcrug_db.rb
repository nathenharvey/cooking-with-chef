name "dcrug_db"
description "Attributes and recipes for DCRUG Database nodes"
run_list(
  "recipe[database]",
  "recipe[mysql::server]",
  "recipe[dcrug::db]"
) 
