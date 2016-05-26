defmodule Keenex.EventCollections.Test do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Keenex.Helpers

  setup_all do
    Helpers.exvcr_setup
    {:ok, keen } = Helpers.new_keenex
    {:ok, [keen: keen] }
  end

  test "post new start event" do
    use_cassette "event collection multiple data" do
      data = %{
        url:           "https://github.com/azukiapp/azk",
        host:          "github.com",
        repo_user:     "azukiapp",
        repo_basename: "azk"
      }
      {status, _} = Keenex.EventCollections.post("start", data)
      assert status == :ok
    end
  end
end
