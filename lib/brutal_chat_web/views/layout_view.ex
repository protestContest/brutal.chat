defmodule BrutalChatWeb.LayoutView do
  use BrutalChatWeb, :html

  embed_templates "../templates/layout/*"

  def room(), do: ""
end
