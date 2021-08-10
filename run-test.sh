#!/usr/bin/env bash

string=$(dfx canister call publisher_test test)

if [[ $string =~ "Failure!" ]]
then
  echo $string
  echo Tests failed
  exit 1
else
  echo $string
  echo Tests passed successfully
  exit 0
fi
