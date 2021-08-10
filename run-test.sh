#!/usr/bin/env bash

string=$(dfx canister call publisher_test test)

if [[ $string =~ "Success!" ]]
then
  echo $string
  echo Tests passed successfully 😄🎉😃
  exit 0
else
  echo $string
  echo Tests failed 🙈🙈🙈
  exit 1
fi
