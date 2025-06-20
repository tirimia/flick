;;; flick.el --- Flick buffers into side-windows     -*- lexical-binding: t; -*-

;; Copyright (C) 2025  Theodor-Alexandru Irimia

;; Author: Theodor-Alexandru Irimia <11174371+tirimia@users.noreply.github.com>
;; Maintainer: Theodor-Alexandru Irimia
;; Version: 0.1.0
;; Package-Requires: ((emacs "24.3"))
;; Homepage: https://github.com/tirimia/flick
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; I don't have a working style that would make configuring all of my
;; side-windows ahead of time with `display-buffer-alist'.  Depending
;; on the project, situation, my disposition and phase of the moon, I
;; want side windows a different way each time.  At first I wrote a
;; little function to put whichever buffer I was in inside the bottom
;; side-window slot 0, but I quickly realized I need a lot more
;; power.  This package is an attempt at providing that.

;;; Code:

(defgroup flick nil
  "Flick buffers to side-windows."
  :link '(url-link "https://github.com/tirimia/flick")
  :prefix "flick-"
  :group 'convenience)

(defconst flick-slot-keys '(?s ?d ?f)
  "List of three characters to be used in prompting for the slot: left, middle, and right.")

(defconst flick-side-keys '(?h ?j ?k ?l)
  "List of four characters to be used in prompting for the window side: left, bottom, top, and right.")

(defconst flick-window-width 0.3
  "Fractional width of left/right side windows (0.0 to 1.0).")

(defconst flick-window-height 0.25
  "Fractional height of top/bottom side windows (0.0 to 1.0).")

(defun flick--format-choices (labels keys)
  "Format LABELS and KEYS into a space-separated choice string."
  (mapconcat (lambda (pair)
               (format "%s(%c)" (car pair) (cdr pair)))
             (cl-mapcar #'cons labels keys)
             " "))

(defun flick--prompt-char (type labels keys)
  "Prompt for a character, selecting a TYPE using LABELS and KEYS."
  (read-char-choice
   (concat type " - " (flick--format-choices labels keys) ": ")
   keys))

(defun flick--prompt ()
  "Prompt for side then slot position, returning a cons cell."
  (let* ((side-labels '(left bottom top right))
         (slot-labels '(-1 0 1))
         (side-char (flick--prompt-char "Side" side-labels flick-side-keys))
         (slot-char (flick--prompt-char "Slot" slot-labels flick-slot-keys))
         (side (nth (cl-position side-char flick-side-keys) side-labels))
         (slot (nth (cl-position slot-char flick-slot-keys) slot-labels)))
    (cons side slot)))

(defun flick ()
  "Flick the buffer to a side-window."
  (interactive)
  (let* ((buf (current-buffer))
         (choice (flick--prompt))
         (side (car choice))
         (slot (cdr choice))
         (size-param (if (memq side '(left right))
                         `(window-width . ,flick-window-width)
                       `(window-height . ,flick-window-height))))
    (display-buffer-in-side-window
     buf `(,size-param
           (side . ,side)
           (slot . ,slot)
           (window-parameters . ((no-delete-other-windows . t)))))
    (delete-window)))

(provide 'flick)
;;; flick.el ends here

