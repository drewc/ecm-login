(import ./types ./database)

(def (login-user username password)
  (def tbl (authenticate username password))
  (if (not tbl) tbl
      (make-login
       (hash-ref tbl 'id)
       (hash-ref tbl 'user_id) username
       (hash-ref tbl 'time) (hash-ref tbl 'until))))
