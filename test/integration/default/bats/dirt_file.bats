#!/usr/bin/env bats

@test "dirt file exists" {
  run ls /dirt.txt
  [ "$status" -eq 0 ]
}
