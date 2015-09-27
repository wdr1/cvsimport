(message "Loading ~/.emacs...")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;   Start-up Settings   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make sure basic load-path is set
(if (or (not (boundp 'load-path))
	(null load-path))
    (setq load-path (list "/usr/local/lib/emacs/site-lisp" 
			  "/usr/local/lib/emacs/lisp")))

;; fix delete
(setq term-setup-hook
          '(lambda ()
             (setq keyboard-translate-table "\C-@\C-a\C-b\C-c\C-d\C-e\C-f\C-g\C-?")
             (global-set-key "\M-h" 'help-for-help)))


;; Add personal library to front of load-path
(setq load-path
      (append (list 
	       (expand-file-name "~/emacslib/")
	       ;; add other libraries here, analogous to previous line
	       )
	      ;; existing path
	      load-path))


;; tramp (for working on remote files)
(add-to-list 'load-path "~/emacslib/tramp/lisp/")
(require 'tramp)
(add-to-list 'Info-default-directory-list "~/emacslib/tramp/texi/")
(setq tramp-default-method "scp")

;; Load modes according to file suffixes.
(load-library "php-mode-102")
(add-hook 'php-mode-user-hook 'turn-on-font-lock)
(setq auto-mode-alist
      (append auto-mode-alist                
	      '(("\\.t$"    . scheme-mode)
          ("\\.doc$"  . text-mode)
          ("mutt-colorado"  . text-mode)
          ("^cvs"  . text-mode)
          ("\\.txt$"  . text-mode)
          ("\\.text$" . text-mode)
          ("\\.elc$"  . emacs-lisp-mode)
          ("\\.ftn$"  . fortran-mode)   
          ("\\.for$"    . fortran-mode)
          ("\\.rpt$"  . rpt-mode)
          ("\\.[.c,h,y]$" . c-mode)
          ("\\.C$" . c-mode)
          ("\\.pl$" . cperl-mode)
;;          ("\\.php$" . php-mode)
          ("\\.txt$"  . text-mode)
          ("\\.bash" . sh-mode)
          ("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode)
          ("\\.cgi$" . cperl-mode)
          ("\\.sql$" . sql-mode)
          ("\\.js$" . java-mode)      ;; close enough
          ("\\.tmpl$" . html-mode)
          ("\\.html$" . html-mode))))

;; Auto-indent (except in text mode)
(global-set-key (kbd "RET") 'newline-and-indent)
(define-key text-mode-map (kbd "RET") 'newline)


;; Change were backup files go
(defun make-backup-file-name (file)
  (concat "~/emacslib/.emacs-backup/" (file-name-nondirectory file))
  )



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;  Cperl Settings  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Use cperl-mode instead  perl-mode
;; (autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)

;; (setq interpreter-mode-alist (append interpreter-mode-alist
;;                                      '(("miniperl" . perl-mode))))

(setq auto-mode-alist
      (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode))  auto-mode-alist ))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;  Custom Function Definitions  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; These functions are to make it easier to turn 
;; backtracing on and off.
(defun dbon () (interactive)
  (setq debug-on-error t))
(defun dboff () (interactive)
  (setq debug-on-error nil))

;; And let's have it on while loading ~/.emacs
(dbon)
(setq meta-flag t)
(setq backup-by-copying              t)  ; To preserve ACLs, date/times, etc.
(setq backup-by-copying-when-linked  t)
(setq inhibit-local-variables        t)	; No Trojan file-variables
(setq enable-recursive-minibuffers   nil)
(setq explicit-shell-file-name "/bin/tcsh")
(setq inhibit-startup-message t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;  RMAIL  Settings  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Mail settings
(setq mail-yank-prefix "> ")
(setq mail-archive-file-name (expand-file-name "~/mail/outbox.txt"))
(setq rmail-ignored-headers "^via:\\|^mail-from:\\|^origin:\\|^status:\\|^received:\\|^x400-originator:\\|^x400-recipients:\\|^x400-received:\\|^x400-mts-identifier:\\|^x400-content-type:\\|^\\(resent-\\|\\)message-id:\\|^summary-line:\\|^resent-date:\\|^nntp-posting-host:|^Content-|^List|^X-Lyris|^Sender:")

;;; RMAIL settings
(setq rmail-file-name "~/nsmail/inbox.rmail")
(setq sc-citation-leader "")
(setq sc-mumble "????")
(setq sc-preferred-header-style 1)

;;; Some packages looks for this (mspool.el specifically)
(require 'custom)

;;;   Load & Config mspools
(autoload 'mspools-show "mspools" "Show outstanding mail spools." t)
(setq mspools-folder-directory "~/Mail/")
(global-set-key "\C-cb" 'mspools-show) 
(setq mspools-update t)                ;Automatically update buffer.

(message "RMAIL loaded")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;   Look & Feel  Settings   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message "Look & Feel settings")

;; Turn off the menubar is we're not going to use it 
(if (not window-system) (menu-bar-mode 0))

;; Help us balance paren's
(show-paren-mode)

;; Overwrite highlighted text
(delete-selection-mode t)


;;;fix the delete key on Solaris 2.5 [ from gnu.emacs.help]
;;;(global-set-key (read-kbd-macro "<delete>") 'delete-char)

;; set the default colors [form gnu.emacs.help] 
;; [[ Useful in Win32, but handled by .Xdefaults otherwise ]]
; (if window-system
;    (progn
;       (setq default-frame-alist 
;             '((width . 80) 
;               (height . 50) 
;               (foreground-color . "darkslateblue")
;               (background-color . "lemonchiffon")
;               (cursor-color . "IndianRed")
;               (pointer-color . "firebrick")
;               ))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;   Time Stamping  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message "Timestamping functions")

;; Can't quite seem to get this to work the way I want it to

; (add-hook 'write-file-hooks 'time-stamp)
; (setq time-stamp-active t)
; (setq time-stamp-line-limit -10)
; (setq time-stamp-start ??)
(autoload 'time-stamp-yyyy-mm-dd "time-stamp" "Time stamp." t)

(defun insert-date-and-name (arg)
    "Insert time stamp.  With prefix, insert stamp + name."
      (interactive "p")
        (let ((time (concat (time-stamp-yyyy-mm-dd) " "
                                  (substring (time-stamp-hh:mm:ss) 0 5) " EDT")))
              (if current-prefix-arg
                  (insert time " <" user-mail-address ">")
                      (insert time))))

(global-set-key "\C-xd" 'insert-date-and-name)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;  Keyboard  Mappings  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "Keyboard mappings")

; M-3 -> imenu
(define-key global-map [M-S-down-mouse-3] 'imenu)
(define-key global-map [(mouse-3)] 'imenu)

; goto-line -> M-g
(global-set-key "\M-g" 'goto-line)
 
; replace-regexp -> ^r
(global-set-key "\C-r" 'replace-regexp)

; replace-regexp -> ^r
(global-set-key "\C-r" 'replace-regexp)

; ispell-buffer -> ^s^s
(global-set-key "\C-xs" 'ispell-buffer)

(setq completion-ignored-extensions
      (append completion-ignored-extensions
              '(".imp" ".aux" ".lis" ".bbx")))

; imenu -> ^c-i
(global-set-key "\C-ci" 'imenu)

;; msb improves the Buffers menu (from menubar or Ctrl-Mouse1) by
;; using submenus to classify available buffers.
;;(require 'msb)

(message "Mode modifications")
;;; Defaults for text-mode
(setq text-mode-hook
  '(lambda () 
     (auto-fill-mode 1)
     (abbrev-mode 1)))

;;; Defaults for text-mode
(setq c++-mode-hook
  '(lambda () 
     (abbrev-mode 1)))

;;; Defaults for text-mode
(setq sgml-mode-hook
  '(lambda () 
     (auto-fill-mode 0)
     ))

;;; Make the default for tabs to be mod 2, and translate them to whitespace.
(setq c-basic-indent 2)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Defaults for sql-mode
(setq sql-mode-hook
  '(lambda () 
	 (setq-default tab-width 2)
	 ))


(eval-after-load "sql" 
  '(font-lock-add-keywords 
	'sql-mode
	
	'(("\\<\\(exception\\|notfound\\|pragma\\|cursor_already_open\\|dup_val_on_index\\|invalid_cursor\\|invalid_number\\|login_denied\\|no_data_found\\|not_logged_on\\|program_error\\|storage_error\\|timeout_on_resource\\|too_many_rows\\|transaction_backed_out\\|value_error\\|zero_divide\\|others\\)\\>"
	   . font-lock-warning-face)     ("\\<loop\\>" . font-lock-keyword-face)
	   ("\\<\\(if\\|elsif\\|else\\|while\\|return\\)\\>" . font-lock-function-name-face)))) 

;; Choose among completions using arrow keys or ^n ^p
;(require 'cycle-mini)

;; When two file buffers would have the same name, distinguish with
;; parts of the path, rather than "file" and "file<2>"
;;(require 'uniquify)

;; Sparc-keys makes gemacs recognize some function keys, such as
;; UNDO, CUT, PASTE.  See the file /usr/local/lib/emacs/site-lisp/sparc-keys.el
;; for full list.  You can also imitate the syntax and change bindings
;; to your own preferences in here.  
;(load "sparc-keys")

; (defun running-x-p ()
;   (and (equal window-system 'x)
;        (= window-system-version 11)))


;; Flash rather than beep.
(setq visible-bell t)


;;  Settings that may do be happy in earlier versions of emacs 
(defun my-emacs-21-settings () (interactive) 
    (global-font-lock-mode t)
    (setq font-lock-maximum-decoration t)
    (add-hook 'font-lock-mode-hook 'turn-on-fast-lock)
    ;; that toolbar is awful.  turn it off!
    (tool-bar-mode -1)
    )

(if (>= emacs-major-version 21)
    (my-emacs-21-settings)
  )

(defun setup-hilit () (interactive)
  (global-font-lock-mode t)
  (setq font-lock-maximum-decoration t)
  (add-hook 'font-lock-mode-hook 'turn-on-fast-lock)
  )

;; do it.
(if window-system (setup-hilit))

;; When searching, highlight the item found so far.
(setq-default search-highlight t)

;; font-lock is syntax-highlighting (and kicks ass)
(defun font-lock-mode-on () (interactive)
  (font-lock-mode 1))

;; Turn on the time, but not the date
;;(display-time)
;;(setq display-time-day-and-date nil)

;; The variable special-display-regexps chooses some buffer names which
;; will bring up new frames rather than using a window within current frame. 
;; The value given here applies to processing traces in AUC-TeX.
(setq special-display-regexps '("\\*.*output\\*"
                                "\\*TeX Help\\*"
                                ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;   Custom Functions  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-insert-function (function)
  (interactive "SFunction Name:   ")
  (let ((that-string "##############################################################################"))
    (substring (length function) (length that-string) that-string)
    insert (concat that-string
		   function
		   " #####")))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;   Special Mode Settings   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;   Supercite  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Add support for Supercite
(autoload 'sc-cite-original     "supercite" "Supercite 3.1" t)
(autoload 'sc-submit-bug-report "supercite" "Supercite 3.1" t)
(add-hook 'mail-citation-hook 'sc-cite-original)
(setq sc-preferred-attribution-list
      '("emailname" "x-attribution" "sc-consult" "sc-lastchoice" "initials"
        "firstname" "middlename-1" "lastname") )

;;;;;;;;;;;   VC  Settings   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq vc-initial-comment t)
(eval-and-compile
  (condition-case ()
      (require 'custom)
    (error nil))
  (if (and (featurep 'custom) (fboundp 'custom-declare-variable))
      nil ;; We've got what we needed
    ;; We have the old custom-library, hack around it!
    (defmacro defgroup (&rest args)
      nil)
    (defmacro defcustom (var value doc &rest args) 
      (` (defvar (, var) (, value) (, doc))))))


;;;;;;;;;;;   SQL Mode  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(require 'sql-mode)
;;(sql-initialize)

(autoload 'sqlplus "sql-mode"
  "Run an interactive SQL*plus session in a separate buffer." t)

(autoload 'sql-mode "sql-mode"
  "Major mode for editing SQL*plus batch files." t)
 (
add-hook 'sql-mode-hook'(lambda ()
                             (progn ;;(setq plsql-indent 3)
                                    (turn-on-font-lock))))

(autoload 'pls-mode  "pls-mode" "PL/SQL Editing Mode" t)
(autoload 'diana-mode  "pls-mode" "DIANA for PL/SQL Browsing Mode" t)

(autoload 'plsql-mode "plsql-mode" "PL/SQL Mode" t)
(add-hook 'plsql-mode-hook'(lambda ()
                             (progn (setq plsql-indent 3)
                                    (turn-on-font-lock))))


(setq auto-mode-alist
      (append '(("\\.sql$" . sql-mode)
                ("\\.pls$"  . plsql-mode)
                ("\\.pld$"  . diana-mode)
                 )
              auto-mode-alist))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;  Custom  Functions  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Perl function skeleton
(defun my-comment-block (comment)
  (interactive "sComment: ")
  (let* ((that-string
"#######################################################################")
    (but-really 
     (substring that-string (length function-name) (length that-string))))
    (insert (concat but-really
                    "\n\n"
                    "/*****************************************************************\n"
                    "*  "
                    comment
                    "\n"
                    "***************************************************************** */\n"
                    "\n"))))

;; C++ Comment block
(defun my-function-skeleton (function-name)
  (interactive "sFunction: ")
  (let* ((that-string
"#######################################################################")
    (but-really 
     (substring that-string (length function-name) (length that-string))))
    (insert (concat but-really
                    "  "
                    function-name
                    "  ###"
                    "\n"
                    "## "
                    "\n"
                    "sub "
                    function-name
                    " {"
                    "\n"
                    "  print \"Please define '"
                    function-name
                    "'.\\n\";\n"
                    "}"
                    "\n\n\n"))))

; Map C-c C-f to the function skeleton
(global-set-key "\C-cf" 'my-function-skeleton)

;; Just the comment line
(defun my-function-comment (function-name)
  (interactive "sFunction: ")
  (let* ((that-string
"#######################################################################")
    (but-really 
     (substring that-string (length function-name) (length that-string))))
    (insert (concat but-really
                    "  "
                    function-name
                    "  ###"
                    "\n"
                    "## "
                    "\n"))))

; Map 
(global-set-key "\C-c\g" 'my-function-comment)

(define-abbrev-table 'c++-mode-abbrev-table '(
    ("sgg" #("s_.getGlobal(" 0 2 (face font-lock-variable-name-face) 2 13 nil) nil 0)
    ("sgc" "getConstGlobal(" nil 0)
    ))



(define-abbrev-table 'sql-mode-abbrev-table '(
    ("db" "DBMS_OUTPUT.PUT_LINE(" nil 3)
    ("begin" "BEGIN" nil 3)
    ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;   Goodbye  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Now that ~/.emacs loaded successfully, turn
;; off bactracing.
(dboff)
(message "Loading ~/.emacs...done")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;  Stuff set by the GUI options below  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;  (Automaticly appended to the end of the file)  ;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 '(cperl-invalid-face (quote (quote nothing))))
(custom-set-faces
 '(cperl-array-face ((t (:foreground "Gold"))))
 '(cperl-hash-face ((t (:foreground "LightBlue")))))

(put 'downcase-region 'disabled nil)

(fset 'insert-comment-block
   [return ?\C-p tab ?/ ?* escape ?6 ?0 ?* return ?* ?  ?  return escape ?6 ?0 ?* ?* ?/ ?\C-p ?  ? ])
