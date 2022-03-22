(in-package "CLOS-CONTACT")
(defclass config-event-types (clog:clog-panel)
  (    (event-type-list :reader event-type-list)
    (delete-btn :reader delete-btn)
    (new-btn :reader new-btn)
    (next-btn :reader next-btn)
    (label-7 :reader label-7)
    (cc-db :reader cc-db)
))
(defun create-config-event-types (clog-obj &key (hidden nil) (class nil) (html-id nil) (auto-place t))
  (let ((panel (change-class (clog:create-div clog-obj :content "<div style=\"box-sizing: content-box; position: static; left: 79px; top: 142px;\" id=\"CLOGB3855237360\"></div><label for=\"\" class=\"\" style=\"box-sizing: content-box; position: absolute; left: 26px; top: 8px; bottom: 148.5px; height: 22px;\" id=\"CLOGB3855237361\">Event Types:</label><button class=\"\" style=\"box-sizing: content-box; position: absolute; left: 220px; top: 8px; width: 45px; height: 22px;\" id=\"CLOGB3855237362\">Edit</button><button style=\"box-sizing: content-box; position: absolute; left: 145px; top: 8px; width: 45px;\" class=\"\" id=\"CLOGB3855237363\">New</button><button class=\"\" style=\"box-sizing: content-box; position: absolute; left: 295px; top: 8px; width: 45px; height: 22px; bottom: 97px;\" id=\"CLOGB3855237364\">Delete</button><select size=\"4\" style=\"box-sizing: content-box; position: absolute; inset: 45px 15px 15px;\" id=\"CLOGB3855237365\"></select>"
         :hidden hidden :class class :html-id html-id :auto-place auto-place) 'config-event-types)))
    (setf (slot-value panel 'event-type-list) (attach-as-child clog-obj "CLOGB3855237365" :clog-type 'CLOG:CLOG-LOOKUP :new-id t))
    (setf (slot-value panel 'delete-btn) (attach-as-child clog-obj "CLOGB3855237364" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'new-btn) (attach-as-child clog-obj "CLOGB3855237363" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'next-btn) (attach-as-child clog-obj "CLOGB3855237362" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'label-7) (attach-as-child clog-obj "CLOGB3855237361" :clog-type 'CLOG:CLOG-LABEL :new-id t))
    (setf (slot-value panel 'cc-db) (attach-as-child clog-obj "CLOGB3855237360" :clog-type 'CLOG:CLOG-DATABASE :new-id t))
    (let ((target (cc-db panel))) (declare (ignorable target)) (setf (database-connection target) (dbi:connect :sqlite3  :database-name "/home/dbotton/common-lisp/clos-contact/clos-contact.db")))
    (set-on-click (next-btn panel) (lambda (target) (declare (ignorable target)) (cet-on-edit target panel)))
    (set-on-click (new-btn panel) (lambda (target) (declare (ignorable target)) (cet-on-new target panel)))
    (set-on-click (delete-btn panel) (lambda (target) (declare (ignorable target)) (cet-on-delete target panel)))
    (let ((target (event-type-list panel))) (declare (ignorable target)) (setf (clog-database target) (clog-database (cc-db panel)))  (setf (table-name target) "event_type") (setf (value-field target) :|rowid|) (setf (option-field target) :|description|) (setf (where-clause target) "") (setf (order-by target) "") (setf (limit target) "") (setf (row-id-name target) "rowid") (setf (table-columns target) '(rowid description))(get-row target panel))
    panel))