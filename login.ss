(import ./login/handler ./login/reset-password ./login/conf :std/getopt)
(export main)

(def (main . args)
  (call-with-getopt ecm-login-main args
    program: "login"
    help: "A simple httpd login server"
    (option 'address "-a" "--address"
      help: "server address"
      default: "127.0.0.1:8080")))

(def (ecm-login-main opt)
  (run (hash-ref opt 'address)))

(def (run address)
  (update-conf)
  (displayln "Running Binary on MacOS")
  (set! login-server (run-login-server address))
  (thread-join! login-server))
