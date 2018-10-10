
@test "Error: BOO_ROOT isn't exist" {
  BOO_ROOT=""
  run boo
  [ $status -eq 72 ]
  [ "$output" = "BOO_ROOT: doesn't exist." ]
}

@test "Error: gievn file doesn't exist" {
  BOO_ROOT="./sample/"
  run boo test.classh
}
