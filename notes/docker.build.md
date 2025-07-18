ERROR: failed to build: failed to solve: docker.io/hexpm/elixir:1.18.4-erlang-27.3.4-debian-bookworm-20250610-slim: failed to resolve source metadata for docker.io/hexpm/elixir:1.18.4-erlang-27.3.4-debian-bookworm-20250610-slim: no match for platform in manifest: not found

https://community.fly.io/t/fly-launch-generates-invalid-dockerfile-for-phoenix-application/25200

没匹配到合适的平台架构，测试这个1.18.4-erlang-27.3.4-debian-bookworm-20250520-slim 可以
比较20250610和20250520， 缺少了linux/amd64 架构支持
https://hub.docker.com/r/hexpm/elixir/tags?name=1.18.4-erlang-27.3.4-debian-bookworm

对比linux/arm64/v8 架构 和 linux/amd64 架构

github上默认使用的是 linux/amd64 x86-64 (AMD64)
本地mac本上的m1芯片，使用的linux/arm64/v8 架构，所以导致本地没问题，github actions里报错，platform不匹配
苹果 M1 芯片是 ​ARM 架构​ 的芯片，​不是 AMD​ 的芯片。

https://docs.docker.com/build/ci/github-actions/multi-platform/
