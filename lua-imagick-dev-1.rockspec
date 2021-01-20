package = "lua-imagick"
version = "dev-1"
source = {
  url = "git+ssh://git@github.com/isage/lua-imagick.git",
}
description = {
  summary = "Pure-C lua bindings to ImageMagick",
  detailed = "Pure-C lua bindings to ImageMagick",
  homepage = "https://github.com/isage/lua-imagick",
  license = "WTFPL"
}
build = {
  type = "cmake",
  variables = {
    LUA_LIBDIR = "$(LUA_LIBDIR)",
    LUA_INCDIR = "$(LUA_INCDIR)",
    LUA_COMMAND = "$(LUA)",
    INST_LIBDIR = "$(LIBDIR)",
  },
}
