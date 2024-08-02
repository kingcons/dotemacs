## Britmacs

Just another emacs config.

At some point, I'll do a nice org-mode writeup but not yet.

### Requirements

* Emacs: 28.1 or later.
* OS: Linux with guix preferred, gracefully falls back to use-package otherwise.
* Apps: git, fortune, pass, w3m for pax, vlc + imagemagick + flac for emms, rtorrent + flood for torrents

### Global Bindings

| Binding |   Behavior   |
|:-------:|:------------:|
| Super-t | Run Torrents |
| Super-e | Run  Mu4e    |
| Super-f | Run elfeed   |
| Super-p | Run  EMMS    |
| Super-r | Random Album |
| Super-l | IRC Libera   |
| Super-i | IRC Twitch   |
| C-c f   | Show Fortune |

### Slime extensions

[gabor]: https://quotenil.com/

I happen to use some lovely emacs extensions for lisp hacking from
[Gabor Melis][gabor], namely for his Pax and Try packages.

They extend `slime-editing-map` as follows:

| Binding |     Behavior     |
|:-------:|:----------------:|
|   C-.   | mgl-pax-document |
|  C-c t  | mgl-try          |

I.e. Showing docs and running tests.
