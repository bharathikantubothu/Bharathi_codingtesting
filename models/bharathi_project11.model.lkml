connection: "testing_bharathiii"
include: "/views/Bharathi_testing_view.view.lkml"

datagroup: bharathi_project11_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: bharathi_project11_default_datagroup
explore: bharathi_testing_view {}
