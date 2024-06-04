(asdf:defsystem #:clos-contact
  :description "New CLOG System"
  :author "some@one.com"
  :license  "BSD"
  :version "0.0.0"
  :serial t
  :depends-on (#:clog)
  :entry-point "clos-contact:start-app"
  :components ((:file "clos-contact")
	       (:file "config-event-types")
	       (:file "manage-contacts")
	       (:file "contact-event")
	       (:file "report-contacts")
	       (:file "report-events")))

(asdf:defsystem #:clos-contact/tools
  :defsystem-depends-on (:clog)
  :depends-on (#:clos-contact #:clog/tools)
  :components ((:clog-file "config-event-types")
               (:clog-file "contact-event")
               (:clog-file "manage-contacts")
               (:clog-file "report-contacts")
               (:clog-file "report-events")))