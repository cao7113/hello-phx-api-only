defmodule DnsResolver do
  @moduledoc """
  DNS Resolver Helper

  iex(hello-phx-api-only-01K0DZ0D5XZE3FJK97HR5DRXZQ@fdaa:2:686c:a7b:2df:4d19:cabc:2)1> :net_kernel.get_state()
  %{
    name: :"hello-phx-api-only-01K0DZ0D5XZE3FJK97HR5DRXZQ@fdaa:2:686c:a7b:2df:4d19:cabc:2",
    started: :static,
    name_domain: :longnames,
    name_type: :static
  }

  https://www.erlang.org/doc/apps/kernel/inet_res.html
  iex> h :inet_res
  """

  @doc """
    Lookup a hostname and return its IP address(es).
    deps/dns_cluster/lib/dns_cluster.ex#lookup

    iex(8)> DnsResolver.lookup "hello-phx-api-only.internal"
    ["fdaa:2:686c:a7b:2df:4d19:cabc:2"]
  """
  def lookup(host, tp \\ :ipv6) do
    tp = tp |> norm_type()

    DNSCluster.Resolver.lookup(host, tp)
    |> Enum.map(fn num_tuple ->
      num_tuple |> :inet.ntoa() |> to_string()
    end)
  end

  def norm_type(:ipv4), do: :a
  def norm_type(:ipv6), do: :aaaa
  def norm_type(:inet), do: :a
  def norm_type(:inet6), do: :aaaa
  def norm_type(tp), do: tp
end
