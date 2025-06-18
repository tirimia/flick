# Flick
![GitHub](https://img.shields.io/github/license/tirimia/flick)

Interactively flick buffers to side-windows with precise control over positioning and sizing.

## Overview

Flick provides a simple, interactive way to move buffers into Emacs side-windows without needing to pre-configure `display-buffer-alist`. Instead of wrestling with complex display buffer configurations that may not fit every situation, flick lets you choose the side and slot position on-the-fly through a two-step prompt system.

Perfect for developers who want different side-window layouts depending on the project, situation, or phase of the moon.

## Installation

```emacs-lisp
(use-package flick
  :vc (:url "https://github.com/tirimia/flick" :rev :newest)
  :bind ("C-c f" . flick))
```

## Usage

1. Run `M-x flick` (or your bound key) from any buffer
2. Choose a side: **h** (left), **j** (bottom), **k** (top), **l** (right)
3. Choose a slot: **s** (left/top), **d** (middle), **f** (right/bottom)

The current buffer will be moved to the selected side-window position, and the original window will be deleted.

## Configuration

### Key Bindings

Customize the prompt keys by setting these constants:

```emacs-lisp
(setq flick-side-keys '(?h ?j ?k ?l))  ; Default: hjkl (vim-style)
(setq flick-slot-keys '(?s ?d ?f))     ; Default: sdf (home row)
```

### Window Sizing

Control the size of side-windows:

```emacs-lisp
(setq flick-window-width 0.3)    ; Width for left/right sides (30% of frame)
(setq flick-window-height 0.25)  ; Height for top/bottom sides (25% of frame)
```

### Complete Configuration Example

```emacs-lisp
(use-package flick
  :vc (:url "https://github.com/tirimia/flick")
  :bind ("C-c f" . flick)
  :config
  (setq flick-window-width 0.35
        flick-window-height 0.3
        flick-side-keys '(?a ?s ?w ?d)    ; Custom keys
        flick-slot-keys '(?q ?w ?e)))     ; Custom slot keys
```

## Features

- **Interactive positioning**: Choose side and slot with simple key presses
- **Persistent windows**: Side-windows survive `delete-other-windows` (C-x 1)
- **Flexible sizing**: Separate width/height ratios for horizontal/vertical sides
- **Customizable keys**: Use any keys you prefer for prompting
- **No pre-configuration**: Works immediately without a complex display-buffer setup
