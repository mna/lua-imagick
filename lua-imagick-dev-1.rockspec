package = "lua-imagick"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/isage/lua-imagick.git"
}
description = {
   summary = "Pure-C lua bindings to ImageMagick",
   detailed = "Pure-C lua bindings to ImageMagick",
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      imagick = {
         sources = "src/imagick.c"
      }
   }
}
