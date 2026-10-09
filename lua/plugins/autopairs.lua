-- nvim-autopairs: auto-close brackets and quotes, VS Code-style.
-- Typing ( [ { " ' ` inserts the closing pair; typing the closer when it's
-- already next to the cursor just steps over it; <BS> between an empty pair
-- deletes both; <CR> between {} splits it onto an indented new line.
--
-- <CR> coexists with blink.cmp: blink owns <CR> while its menu is open
-- (accept) and falls back to this plugin's <CR> otherwise.
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    check_ts = true, -- use treesitter: don't pair quotes inside strings/comments
  },
}
