-- WakaTime: automatic time tracking (same service as the VS Code extension).
-- Vimscript plugin; it wires its own autocommands and auto-downloads
-- wakatime-cli on first run, so no setup()/config is needed here.
-- Loaded eagerly so tracking starts the moment a buffer is opened.
return {
  "wakatime/vim-wakatime",
  lazy = false,
}
