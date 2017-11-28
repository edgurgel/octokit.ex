defmodule Tentacat.CommitsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Commits

  doctest Tentacat.Commits

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

#  setup_all do
#    HTTPoison.start
#  end

  test "list/3" do
    use_cassette "commits#list" do
      assert {200,[],_} =  list("soudqwiggle", "elixir-conspiracy", @client)
    end
  end

  test "filter/4" do
    use_cassette "commits#filter" do
      {_,[%{"sha" => sha}],_} = filter("soudqwiggle", "elixir-conspiracy", %{sha: "09fe12ca25d0440f143ab331e4684a8622d6e4e5"}, @client)
      assert sha == "09fe12ca25d0440f143ab331e4684a8622d6e4e5"
    end
  end

  test "find/4" do
    use_cassette "commits#find" do
      {_,%{"sha" => sha},_} = find("09fe12ca25d0440f", "soudqwiggle", "elixir-conspiracy", @client)
      assert sha == "09fe12ca25d0440f143ab331e4684a8622d6e4e5"
    end
  end

  test "compare/5" do
    use_cassette "commits#compare" do
      {_,%{"total_commits" => total_commits},_} = compare("master", "09fe12ca25d0440f", "soudqwiggle", "elixir-conspiracy", @client)
      assert total_commits == 0
    end
  end
end
