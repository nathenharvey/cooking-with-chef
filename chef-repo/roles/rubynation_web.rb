name "rubynation_web"
description "Attributes and recipes for Rubynation Webserver nodes"
run_list(
  "recipe[passenger_apache2::mod_rails]",
  "recipe[rubynation::web]"
) 
