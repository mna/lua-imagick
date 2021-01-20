package = "lua-imagick"
version = "1.0.1-1"
source = {
   url = "git+ssh://git@github.com/mna/lua-imagick.git"
}
description = {
   summary = "Pure-C lua bindings to ImageMagick",
   detailed = "Pure-C lua bindings to ImageMagick",
   homepage = "https://github.com/mna/lua-imagick",
   license = "WTFPL"
}
build = {
   type = "cmake",
   variables = {
      INST_LIBDIR = "$(LIBDIR)",
      LUA_COMMAND = "$(LUA)",
      LUA_INCDIR = "$(LUA_INCDIR)",
      LUA_LIBDIR = "$(LUA_LIBDIR)"
   }
}
