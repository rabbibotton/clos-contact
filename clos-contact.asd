(asdf:defsystem #:clos-contact
  :description "New CLOG System"
  :author "some@one.com"
  :license  "BSD"
  :version "0.0.0"
  :serial t
  :depends-on (#:clog)
  :components ((:file "clos-contact")
	       (:file "config-event-types")
	       (:file "manage-contacts")
	       (:file "contact-event")
	       (:file "report-contacts")
	       (:file "report-events")))

