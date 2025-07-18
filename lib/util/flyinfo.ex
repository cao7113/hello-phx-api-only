defmodule Flyinfo do
  def env_vars do
    ~w[
      FLY_APP_NAME
      FLY_PRIVATE_IP
      FLY_PUBLIC_IP
      FLY_REGION
      FLY_IMAGE_REF
      FLY_MACHINE_ID
      FLY_MACHINE_VERSION
      FLY_VM_MEMORY_MB
      FLY_PROCESS_GROUP
      FLY_SSH
      FLY_ALLOC_ID
    ]
    |> Enum.into(%{}, fn env ->
      {env, System.get_env(env, nil)}
    end)
  end
end
