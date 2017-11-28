defmodule Tentacat.Teams.RepositoriesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Teams.Repositories

  doctest Tentacat.Teams.Repositories

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "teams/repositories#list" do
      assert  elem(list(1500000, @client),1) == []
    end
  end
end
