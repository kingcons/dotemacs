## Britmacs

Just another emacs config.

At some point, I'll do a nice org-mode writeup but not yet.

### Requirements

* Emacs: 28.1 or later.
* OS: Linux with guix preferred, gracefully falls back to use-package otherwise.
* Apps: git, fortune, pass, vlc + imagemagick + flac for emms, isync + mu4e for email, rtorrent + flood for torrents

### Global Bindings

| Binding |   Behavior   |
|:-------:|:------------:|
| Super-e | Run  Mu4e    |
| Super-p | Run  EMMS    |
| Super-r | Random Album |
| Super-t | Run Torrents |
| Super-l | IRC ~.town   |
| Super-i | IRC Twitch   |
| Super-f | Run elfeed   |
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

### Email

Well, email is _complicated_.

At least isync and mu4e must be installed and you'll probably want to frob the load-path for mu4e.

Then run an initial:

```
mbsync -a -c ~/.emacs.d/.mbsyncrc
mu init -m .Mail/
mu index
```
