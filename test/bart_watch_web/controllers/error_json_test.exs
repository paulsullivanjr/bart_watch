defmodule BartWatchWeb.ErrorJSONTest do
  use BartWatchWeb.ConnCase, async: true

  test "renders 404" do
    assert BartWatchWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert BartWatchWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
