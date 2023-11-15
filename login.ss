(import :std/net/httpd :std/misc/ports
	:std/db/postgresql :std/db/dbi
	:std/net/uri)
(import ./api)


(def current-static-path (make-parameter "~/me/src/ecm-user/static/"))
(def static-path-expand (cut path-expand <> (current-static-path)))


(def dbg #f)

(def (login/POST req res)
  (let* ((params (form-url-decode (utf8->string (http-request-body req))))
	 (u (assget "u" params))
	 (pw (assget "p" params))
	 (keep (assget "keep" params))
	 (login (login-user u pw))
	 (getps (form-url-decode (http-request-params req)))
	 (q (or (assget "q" getps) "/ecm/index")))
    (if login 
      (http-response-write
	 res 302 `(("Set-Cookie" . (string-append "ecm-login=" (login-id login)))
		   ("Location" . ,q))
	 #f)
      (http-response-write res 302 `(("Location" . ,(string-append "/ecm/login?_f&q=" q))) #f))))

(def (login-handler req res)
  (set! dbg req)
  (if (equal? 'POST (http-request-method req))
    (login/POST req res)
  (http-response-file
   res '(("Content-Type" . "text/html"))
   (static-path-expand "login-dark.html"))))

(def (login.js req res)
  (http-response-file
   res '(("Content-Type" . "text/javascript"))
   (static-path-expand "login.js")))


(def login-mux
  (make-static-http-mux
   (list->hash-table
    `(("/ecm/login" .,(cut login-handler <> <>))
      ("/ecm/login/login.js" .,(cut login.js <> <>))))
   (cut login-handler <> <>)))

(def (run-login-server (address "10.42.1.100:8080"))
  (start-http-server! address mux: login-mux))


(def login-server #f)
