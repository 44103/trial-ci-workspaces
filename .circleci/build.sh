#!/bin/bash

cd infrastructure/functions/lambda
rustup target add x86_64-unknown-linux-musl
for func in $(ls src/bin/*.rs); do
  cargo build --release --target x86_64-unknown-linux-musl --bin $func
done
