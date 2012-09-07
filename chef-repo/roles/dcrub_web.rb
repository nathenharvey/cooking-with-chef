name "dcrug_web"
description "Attributes and recipes for DCRUG Webserver nodes"
run_list(
  "recipe[passenger_apache2::mod_rails]",
  "recipe[dcrug::web]"
) 
