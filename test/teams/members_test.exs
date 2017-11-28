defmodule Tentacat.Teams.MembersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Teams.Members

  doctest Tentacat.Teams.Members

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "teams/members#list" do
      assert elem(list(1500000, @client),1) == []
    end
  end

  test "find/3" do
    use_cassette "teams/members#find" do
      {_,%{"state" => state},_} = find(1500000, "username", @client)
      assert state == "active"
    end
  end

  test "create/4" do
    use_cassette "teams/members#create" do
      {_,%{"state" => state},_} = create(1500000, "username", %{}, @client)
      assert state == "active"
    end
  end

  test "delete/3" do
    use_cassette "teams/members#delete" do
      {status_code, _,_} = delete(1500000, "username", @client)
      assert status_code == 204
    end
  end
end
