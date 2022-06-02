import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :brutal_chat, BrutalChatWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "IRJ3welCHktFuV10PGUYgV7ZTZJPwn5T9mtJan9MdngTNpt0R2sQdH/k6GQkdmqS",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
