(defpackage #:clos-contact
  (:use #:cl #:clog #:clog-gui)
  (:export start-app))

(in-package :clos-contact)

(defun on-manage-contacts (obj)
  (let* ((app (connection-data-item obj "app-data"))
	 (win (create-gui-window obj :height 240
				     :width 400
				     :title "Manage Contacts")))	 
    (declare (ignore app))
    (create-manage-contacts (window-content win))))

(defun manage-contacts-find (target panel)
 (input-dialog panel "Enter search string eg, (name like 'david%')"
		(lambda (input)
		  (when input
		    (setf (where-clause (contact-table panel)) input)
		    (get-row (contact-table panel) panel)))))

(defun on-new-event (obj)
  (let* ((app (connection-data-item obj "app-data"))
	 (win (create-gui-window obj
				 :height 350
				 :width 450
				 :title "New Contact Event")))	 
    (declare (ignore app))
    (setf (win (create-contact-event (window-content win))) win)))

(defun contact-event-submit (target panel)
  (insert-row (contact-event-table panel) panel)
  (window-close (win panel)))

(defun on-config-event-types (obj)
  (let* ((app (connection-data-item obj "app-data"))
	 (win (create-gui-window obj :width 400
				     :title "New Config Event Types")))	 
    (declare (ignore app))
    (create-config-event-types (window-content win))))

(defun cet-on-new (target panel)
  (input-dialog panel "Enter new event type description"
		(lambda (input)
		  (when input
		    (dbi:do-sql (database-connection (cc-db panel))
		      "INSERT INTO event_type (description) VALUES (?)" (list input))
		    ;; get-row on one of the table related database controls
		    ;; refreshes the query.
		    (get-row (event-type-list panel) panel)))))
		    
(defun cet-on-edit (target panel)
  (let ((rowid (value (event-type-list panel))))
    (unless (equal rowid "")
      (input-dialog panel "Update event type description"
		    (lambda (update)
		      (when update
			(dbi:do-sql (database-connection (cc-db panel))
			  "UPDATE event_type SET description=? WHERE rowid=?"
			  (list update rowid))
			(get-row (event-type-list panel) panel)))
		    :default-value (select-text (event-type-list panel))))))

(defun cet-on-delete (target panel)
  (let ((rowid (value (event-type-list panel))))
    (unless (equal rowid "")
      (confirm-dialog panel
		      (format nil "Delete - ~A?"
			      (select-text (event-type-list panel)))
		    (lambda (del)
		      (when del
			(dbi:do-sql (database-connection (cc-db panel))
			  "DELETE FROM event_type WHERE rowid=?" (list rowid))
			(get-row (event-type-list panel) panel)))))))

(defun on-report-contacts (obj)
  (let* ((app (connection-data-item obj "app-data"))
	 (win (create-gui-window obj :width 400
				     :title "Contacts Report")))	 
    (declare (ignore app))
    (create-report-contacts (window-content win))))

(defun on-report-events (obj)
  (let* ((app (connection-data-item obj "app-data"))
	 (win (create-gui-window obj :width 400
				     :title "Events Report")))	 
    (declare (ignore app))
    (create-report-events (window-content win))))

(defun report-events-run (target panel)
  (query-row (event-table panel) panel
	     (format nil "SELECT e.description, c.start_dtime, c.end_dtime, c.notes ~
                          FROM contact_event c ~
                          INNER JOIN event_type e ~
                          ON c.event_type_id=e.rowid
                          WHERE c.contact_id=~A"
		     (value (contact-list panel)))))

(defun on-help-about (obj)
  (let* ((about (create-gui-window obj
				   :title   "About"
				   :content "<div class='w3-black'>
                                         <center><img src='/img/clogwicon.png'></center>
	                                 <center>clos-contact</center>
	                                 <center>clos-contact</center></div>
			                 <div><p><center>A New App</center>
                                         <center>(c) 2022 - Some One</center></p></div>"
				   :hidden  t
				   :width   200
				   :height  200)))
    (window-center about)
    (setf (visiblep about) t)
    (set-on-window-can-size about (lambda (obj)
				    (declare (ignore obj))()))))



(defclass app-data ()
  ((data
    :accessor data)))

(defun on-new-window (body)
  (let ((app (make-instance 'app-data)))
    (setf (connection-data-item body "app-data") app)
    (setf (title (html-document body)) "CLOS-CONTACT")
    (clog-gui-initialize body)
    (add-class body "w3-indigo")  
    (let* ((menu-bar    (create-gui-menu-bar body))
	   (icon-item   (create-gui-menu-icon menu-bar :on-click 'on-help-about))
	   (cntct-item  (create-gui-menu-drop-down menu-bar :content "Contacts"))
	   (contacts    (create-gui-menu-item cntct-item :content "Manage Contacts" :on-click 'on-manage-contacts))
	   (events      (create-gui-menu-item cntct-item :content "New Contact Event" :on-click 'on-new-event))
	   (config-item (create-gui-menu-drop-down menu-bar :content "Config"))
	   (event-types (create-gui-menu-item config-item :content "Manage Event Types" :on-click 'on-config-event-types))
	   (report-item (create-gui-menu-drop-down menu-bar :content "Reports"))
	   (contact-rep (create-gui-menu-item report-item :content "Contact List" :on-click 'on-report-contacts))
	   (events-rep  (create-gui-menu-item report-item :content "Contact Event List" :on-click 'on-report-events))
	   (help-item   (create-gui-menu-drop-down menu-bar :content "Help"))
	   (help-about  (create-gui-menu-item help-item :content "About" :on-click 'on-help-about))
	   (full-screen (create-gui-menu-full-screen menu-bar)))
      (declare (ignore icon-item help-about full-screen)))))

(defparameter *database* "")

(defun start-app ()
  (initialize 'on-new-window
   :static-root (merge-pathnames "./www/"
				 (asdf:system-source-directory :clos-contact)))
  (setf *database* (format nil "~A/clos-contact.db"
			   (asdf:system-source-directory :clos-contact)))
  (open-browser))
