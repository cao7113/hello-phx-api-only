# Fly notes

- FLY_API_TOKEN fly launch automatically set Secrets in Repository secrets in https://github.com/cao7113/hello-phx-api-only/settings/secrets/actions
  Setting FLY_API_TOKEN secret in GitHub repository settings
- Set secrets on hello-phx-api-only: SECRET_KEY_BASE
- `fly deploy` command automatically generate a file: .github/workflows/fly-deploy.yml

## Clustering

https://fly.io/docs/elixir/the-basics/clustering/

```
# configure node for distributed erlang with IPV6 support
export ERL_AFLAGS="-proto_dist inet6_tcp"
export ECTO_IPV6="true"
export DNS_CLUSTER_QUERY="${FLY_APP_NAME}.internal"
export RELEASE_DISTRIBUTION="name"
export RELEASE_NODE="${FLY_APP_NAME}-${FLY_IMAGE_REF##*-}@${FLY_PRIVATE_IP}"
```

```
root@d8d4017a0d1438:/app# env|grep FLY
FLY_PRIVATE_IP=fdaa:2:686c:a7b:465:821d:76c3:2
FLY_MACHINE_ID=d8d4017a0d1438
FLY_ALLOC_ID=d8d4017a0d1438
FLY_VM_MEMORY_MB=512
FLY_APP_NAME=hello-phx-api-only
FLY_PROCESS_GROUP=app
FLY_PUBLIC_IP=2605:4c40:19:19b:0:821d:76c3:1
FLY_MACHINE_VERSION=01K0C2RJDPYWESCYT00YJXZM9A
FLY_REGION=nrt
FLY_SSH=1
FLY_IMAGE_REF=registry.fly.io/hello-phx-api-only:deployment-01K0C2PDQKF6X615NXX8V6VBXC
root@d8d4017a0d1438:/app# echo "${FLY_APP_NAME}-${FLY_IMAGE_REF##*-}@${FLY_PRIVATE_IP}"
hello-phx-api-only-01K0C2PDQKF6X615NXX8V6VBXC@fdaa:2:686c:a7b:465:821d:76c3:2
```

### Cluster from Home

https://fly.io/docs/elixir/advanced-guides/clustering-from-home-to-your-app-in-fly/
