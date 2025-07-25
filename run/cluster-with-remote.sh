#!/bin/bash

# After opening a WireGuard connection to your Fly.io network, copy this file
# into the directory for your Elixir application. Run the script to start the
# local Elixir project and cluster it to an application running on Fly.io.

# In order for this to work:
# - Your wireguard connection must be up.
# - When run from a directory with a `fly.toml` file, `flyctl` command is used
#   to access information about the application.
# - Set the ENV `CLUSTER_APP_NAME` to specify a different hosted app name.
# - Set the ENV `RELEASE_COOKIE` to override the Erlang cookie used for
#   clustering. It uses the the value from the deployed app if it is set there.
# - Run the script.

set -e

if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install it before running this script. It is a command-line JSON processor."
    exit 1
fi

# Check if CLUSTER_APP_NAME is set and use it if found
if [[ -n $CLUSTER_APP_NAME ]]; then
    # Use the override app_name from the ENV
    json_data=$(fly status --app ${CLUSTER_APP_NAME} --json)
else
    # Use the app_name for the current app
    json_data=$(fly status --json)
fi

# Use an explicit RELEASE_COOKIE value if provided
if [ -n "$RELEASE_COOKIE" ]; then
    release_cookie=$RELEASE_COOKIE
else
    # Extract the RELEASE_COOKIE value from the deployed app
    release_cookie=$(echo "$json_data" | jq -r '.Machines[] | select(.state == "started") | .config | .env | .RELEASE_COOKIE' | head -n 1)

    if [ $release_cookie == "null" ]; then
        echo "The deployed application did not set RELEASE_COOKIE ENV. If the cookie is static on the server, provide it locally through RELEASE_COOKIE."
        exit 1
    fi
fi

# Extract the app_name
app_name=$(echo "$json_data" | jq -r '.Name')

# Extract private_ip for the first started machine
private_ip=$(echo "$json_data" | jq -r '.Machines[] | select(.state == "started") | .private_ip' | head -n 1)

# Extract image_ref tag hash for the first started machine
image_tags=$(echo "$json_data" | jq -r '.Machines[] | select(.state == "started") | .image_ref.tag | sub("deployment-"; "")' | head -n 1)

if [ -z "$private_ip" ]; then
    echo "No instances appear to be running at this time."
    exit 1
fi

# Assemble the full node name
full_node_name="${app_name}-${image_tags}@${private_ip}"
echo Attempting to connect to $full_node_name

# IMPORTANT:
# ==========
# Fly.io uses an IPv6 network internally for private IPs. The BEAM needs IPv6
# support to be enabled explicitly.
#
# The issue is, if it's enabled globally like in a `.bashrc` file, then setting
# it here essentially flips it OFF. If not set globally, then it should be set
# here. Choose the version that fits your situation.
#
# It's the `--erl "-proto_dist inet6_tcp"` portion.

# export ERL_AFLAGS="-kernel shell_history enabled -proto_dist inet6_tcp"

# Toggles on IPv6 support for the local node being started.
# iex --erl "-proto_dist inet6_tcp" --sname local --cookie ${release_cookie} --hidden -e "IO.inspect(Node.connect(:'${full_node_name}'), label: \"Node Connected?\"); IO.inspect(Node.list(:hidden), label: \"Connected Nodes\")" -S mix phx.server

# Does NOT toggle on IPv6 support, assuming it is enabled some other way.
iex --sname local --cookie ${release_cookie} --hidden -e "IO.inspect(Node.connect(:'${full_node_name}'), label: \"Node Connected?\"); IO.inspect(Node.list(:hidden), label: \"Connected Nodes\")" -S mix phx.server
