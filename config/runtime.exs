import Config

require Logger

if System.get_env("PHX_SERVER") && System.get_env("RELEASE_NAME") do
  config :brutal_chat, BrutalChatWeb.Endpoint, server: true
end

if config_env() == :prod do
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "brutal.chat"
  port = String.to_integer(System.get_env("PORT") || "80")

  config :brutal_chat, BrutalChatWeb.Endpoint,
    url: [host: host, port: 443],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base

  [adj_salt, anm_salt] = System.get_env("SALTS", "0:0") |> String.split(":")

  Logger.info("Salts: #{adj_salt}:#{anm_salt}")

  config :brutal_chat, BrutalChat.Names,
    adj_salt: String.to_integer(adj_salt),
    anm_salt: String.to_integer(anm_salt)
end
