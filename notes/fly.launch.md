dependencies are up to date
Compiling 9 files (.ex)
Generated hi app
Detected a Phoenix app
Creating app in /Users/rj/dev/elab/hello-phx-api-only
We're about to launch your Phoenix app on Fly.io. Here's what you're getting:

Organization: 草色青青           (fly launch defaults to the personal org)
Name:         hello-phx-api-only     (derived from your directory name)
Region:       Tokyo, Japan           (this is the fastest region for you)
App Machines: shared-cpu-1x, 1GB RAM (most apps need about 1GB of RAM)
Postgres:     <none>                 (not requested)
Redis:        <none>                 (not requested)
Tigris:       <none>                 (not requested)

? Do you want to tweak these settings before proceeding? Yes
Opening https://fly.io/cli/launch/776f636e6d61746b6b37676e636e6277756c63746165696d6d67327a77646a6e ...

Waiting for launch data... Done
Created app 'hello-phx-api-only' in organization 'personal'
Admin URL: https://fly.io/apps/hello-phx-api-only
Hostname: hello-phx-api-only.fly.dev
Setting FLY_API_TOKEN secret in GitHub repository settings
Set secrets on hello-phx-api-only: SECRET_KEY_BASE
Preparing system for Elixir builds
Installing application dependencies
Running Docker release generator
Wrote config file fly.toml
Validating /Users/rj/dev/elab/hello-phx-api-only/fly.toml
...
=> => pushing manifest for registry.fly.io/hello-phx-api-only:deployment-01K0C0SZMG53EMJ76ZWQ19XX3F@sha256:97b50052543ff5fc9  5.4s
--> Build Summary:  (​)
--> Building image done
image: registry.fly.io/hello-phx-api-only:deployment-01K0C0SZMG53EMJ76ZWQ19XX3F
image size: 47 MB

Watch your deployment at https://fly.io/apps/hello-phx-api-only/monitoring

Provisioning ips for hello-phx-api-only
 Dedicated ipv6: 2a09:8280:1::86:f75e:0
 Shared ipv4: 66.241.124.37
 Add a dedicated ipv4 with: fly ips allocate-v4

This deployment will:
* create 2 "app" machines

No machines in group app, launching a new machine
Creating a second machine to increase service availability
Finished launching new machines
-------
NOTE: The machines for [app] have services with 'auto_stop_machines = "stop"' that will be stopped when idling

-------
Checking DNS configuration for hello-phx-api-only.fly.dev

Visit your newly deployed app at https://hello-phx-api-only.fly.dev/
