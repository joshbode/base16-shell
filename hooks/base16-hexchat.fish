#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Setup config variables and env
# ----------------------------------------------------------------------

# Allow users to optionally configure their hexchat plugin path and set
# the value if one doesn't exist. This runs each time a script is
# switched so it's important to check for previously set values.

if test -z "$BASE16_HEXCHAT_PATH"
  set BASE16_HEXCHAT_PATH "$HOME/.config/base16-hexchat"
end

# If BASE16_HEXCHAT_PATH doesn't exist, stop hook
if not test -d "$BASE16_HEXCHAT_PATH"
  return 2
end

# If HEXCHAT_COLORS_CONF_PATH hasn't been configured, stop hook
if test -z "$HEXCHAT_COLORS_CONF_PATH"
  return 1
end

# If HEXCHAT_COLORS_CONF_PATH has been configured, but the file doesn't
# exist
if test -n "$HEXCHAT_COLORS_CONF_PATH"; \
  and not test -f "$HEXCHAT_COLORS_CONF_PATH"
  echo "\$HEXCHAT_COLORS_CONF_PATH is not a file."
  return 2
end

set hexchat_theme_path "$BASE16_HEXCHAT_PATH/colors/base16-$BASE16_THEME.conf"

if not test -f "$hexchat_theme_path"
  set output $(string join \
    "'$BASE16_THEME' theme doesn't exist in base16-hex. Make sure " \
    "the local repository is using the latest commit. \`cd\` to " \
    "the directory and try doing a \`git pull\`.")

  echo $output
  return 2
end

# ----------------------------------------------------------------------
# Execution
# ----------------------------------------------------------------------

cp -f "$hexchat_theme_path" "$HEXCHAT_COLORS_CONF_PATH"
