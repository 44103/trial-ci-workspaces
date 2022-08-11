#!/bin/bash

for dir in $(ls -d infrastructure/functions/*/); do
  cd $dir
  rustup target add x86_64-unknown-linux-musl
  cargo build --release --target x86_64-unknown-linux-musl
  cd ../../..
done
