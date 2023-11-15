#!/usr/bin/env gxi
;; -*- Gerbil -*-

  (import :std/build-script)

  (defbuild-script
    '("login/conf"
      "login/database"
      "login/types"
      "login/api"
      "login/handler"
       (exe: "login")
))
