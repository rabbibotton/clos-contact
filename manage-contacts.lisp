(in-package "CLOS-CONTACT")
(defclass manage-contacts (clog:clog-panel)
  (    (delete-btn :reader delete-btn)
    (update-btn :reader update-btn)
    (insert-btn :reader insert-btn)
    (next-btn :reader next-btn)
    (find-btn :reader find-btn)
    (email :reader email)
    (phone :reader phone)
    (nickname :reader nickname)
    (label-8 :reader label-8)
    (label-7 :reader label-7)
    (label-6 :reader label-6)
    (name :reader name)
    (label-4 :reader label-4)
    (contact-table :reader contact-table)
    (cc-db :reader cc-db)
))
(defun create-manage-contacts (clog-obj &key (hidden nil) (class nil) (html-id nil) (auto-place t))
  (let ((panel (change-class (clog:create-div clog-obj :content "<div id=\"CLOGB38552400342\" style=\"box-sizing: content-box; position: static; left: 82px; top: 107px;\"></div><div id=\"CLOGB38552413013\" style=\"box-sizing: content-box; position: static; left: 64px; top: 122px;\"></div><label for=\"\" id=\"CLOGB38552420004\" class=\"\" style=\"box-sizing: content-box; position: absolute; left: 10px; top: 10px;\">Name</label><input type=\"TEXT\" value=\"\" id=\"CLOGB38552420375\" style=\"box-sizing: content-box; position: absolute; left: 140px; top: 10px;\"><label for=\"\" id=\"CLOGB38552420556\" class=\"\" style=\"box-sizing: content-box; position: absolute; left: 10px; top: 50px;\">Nick Name</label><label for=\"\" id=\"CLOGB38552420767\" class=\"\" style=\"box-sizing: content-box; position: absolute; left: 10px; top: 90px;\">Phone Number</label><label for=\"\" id=\"CLOGB38552421618\" class=\"\" style=\"box-sizing: content-box; position: absolute; left: 10px; top: 130px;\">E-mail</label><input type=\"TEXT\" value=\"\" id=\"CLOGB38552421789\" style=\"box-sizing: content-box; position: absolute; left: 140px; top: 50px;\"><input type=\"TEXT\" value=\"\" id=\"CLOGB385524218310\" style=\"box-sizing: content-box; position: absolute; left: 140px; top: 90px;\"><input type=\"TEXT\" value=\"\" id=\"CLOGB385524218611\" style=\"box-sizing: content-box; position: absolute; left: 140px; top: 130px;\"><button id=\"CLOGB385524241212\" class=\"\" style=\"box-sizing: content-box; position: absolute; left: 15px; top: 170px; width: 55px; height: 22px; bottom: 40px;\">Find</button><button class=\"\" style=\"box-sizing: content-box; position: absolute; left: 90px; top: 170px; width: 55px; height: 22px; bottom: 40px;\" id=\"CLOGB3855242706\">Next</button><button class=\"\" style=\"box-sizing: content-box; position: absolute; left: 165px; top: 170px; width: 55px; height: 22px; bottom: 42px;\" id=\"CLOGB3855242716\">Insert</button><button class=\"\" style=\"box-sizing: content-box; position: absolute; left: 240px; top: 170px; width: 55px; height: 22px;\" id=\"CLOGB3855242725\">Update</button><button class=\"\" style=\"box-sizing: content-box; position: absolute; left: 315px; top: 170px; width: 55px; height: 22px;\" id=\"CLOGB3855242743\">Delete</button>"
         :hidden hidden :class class :html-id html-id :auto-place auto-place) 'manage-contacts)))
    (setf (slot-value panel 'delete-btn) (attach-as-child clog-obj "CLOGB3855242743" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'update-btn) (attach-as-child clog-obj "CLOGB3855242725" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'insert-btn) (attach-as-child clog-obj "CLOGB3855242716" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'next-btn) (attach-as-child clog-obj "CLOGB3855242706" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'find-btn) (attach-as-child clog-obj "CLOGB385524241212" :clog-type 'CLOG:CLOG-BUTTON :new-id t))
    (setf (slot-value panel 'email) (attach-as-child clog-obj "CLOGB385524218611" :clog-type 'CLOG:CLOG-FORM-ELEMENT :new-id t))
    (setf (slot-value panel 'phone) (attach-as-child clog-obj "CLOGB385524218310" :clog-type 'CLOG:CLOG-FORM-ELEMENT :new-id t))
    (setf (slot-value panel 'nickname) (attach-as-child clog-obj "CLOGB38552421789" :clog-type 'CLOG:CLOG-FORM-ELEMENT :new-id t))
    (setf (slot-value panel 'label-8) (attach-as-child clog-obj "CLOGB38552421618" :clog-type 'CLOG:CLOG-LABEL :new-id t))
    (setf (slot-value panel 'label-7) (attach-as-child clog-obj "CLOGB38552420767" :clog-type 'CLOG:CLOG-LABEL :new-id t))
    (setf (slot-value panel 'label-6) (attach-as-child clog-obj "CLOGB38552420556" :clog-type 'CLOG:CLOG-LABEL :new-id t))
    (setf (slot-value panel 'name) (attach-as-child clog-obj "CLOGB38552420375" :clog-type 'CLOG:CLOG-FORM-ELEMENT :new-id t))
    (setf (slot-value panel 'label-4) (attach-as-child clog-obj "CLOGB38552420004" :clog-type 'CLOG:CLOG-LABEL :new-id t))
    (setf (slot-value panel 'contact-table) (attach-as-child clog-obj "CLOGB38552413013" :clog-type 'CLOG:CLOG-ONE-ROW :new-id t))
    (setf (slot-value panel 'cc-db) (attach-as-child clog-obj "CLOGB38552400342" :clog-type 'CLOG:CLOG-DATABASE :new-id t))
    (let ((target (cc-db panel))) (declare (ignorable target)) (setf (database-connection target) (dbi:connect :sqlite3  :database-name "/home/dbotton/common-lisp/clos-contact/clos-contact.db")))
    (let ((target (contact-table panel))) (declare (ignorable target)) (setf (clog-database target) (clog-database (cc-db panel)))  (setf (table-name target) "contact") (setf (where-clause target) "") (setf (order-by target) "name") (setf (limit target) "") (setf (row-id-name target) "rowid") (setf (table-columns target) '(rowid name nickname phone email)))
    (set-on-click (find-btn panel) (lambda (target) (declare (ignorable target)) (manage-contacts-find target panel)))
    (set-on-click (next-btn panel) (lambda (target) (declare (ignorable target)) (next-row (contact-table panel) panel)))
    (set-on-click (insert-btn panel) (lambda (target) (declare (ignorable target)) (insert-row (contact-table panel) panel)))
    (set-on-click (update-btn panel) (lambda (target) (declare (ignorable target)) (update-row (contact-table panel) panel)))
    (set-on-click (delete-btn panel) (lambda (target) (declare (ignorable target)) (delete-row (contact-table panel) panel)))
    panel))
