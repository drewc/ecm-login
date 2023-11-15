(import ./conf :std/text/json :std/db/dbi :std/db/postgresql)
(export #t)

(def (database-connect)
   (let* ((db (conf-value '(database master)))
	  (host (conf-value 'host db))
          (port (conf-value 'port db))
          (dbname (conf-value 'database db))
          (u (conf-value 'username db))
          (p (conf-value 'password db)))
     (sql-connect postgresql-connect host: host port: port user: u passwd: p db: dbname)))


(def (authenticate username password)
  (def db (database-connect))
  (let (res (car (sql-eval-query db "SELECT login.login_user($1, $2)"
				 username password)))
    (sql-close db)
    (if (not res) res
	(call-with-input-string res read-json))))
