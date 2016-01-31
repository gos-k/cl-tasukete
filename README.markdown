# cl-tasukete

[![CircleCI Status](https://circleci.com/gh/gos-k/cl-tasukete.svg?style=shield)](https://circleci.com/gh/somewrite-adtech/cl-tasukete)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://opensource.org/licenses/mit-license.php)
[![Quicklisp](http://quickdocs.org/badge/cl-tasukete.svg)](http://quickdocs.org/cl-tasukete/)

Please help me, Common Lisper.

## Description

'cl-tasukete' is a library of collecting debug information and output somewhere.

## Installation

If you use Roswell then

```
cd ~/.roswell/local-projects
git clone https://github.com/gos-k/cl-tasukete.git
```

If you use Quicklisp then

```
cd ~/quicklisp/local-projects
git clone https://github.com/gos-k/cl-tasukete.git
```

## Usage

Start cl-tasukete.

```common-lisp
(ql:quickload :cl-tasukete)
(tasukete:start)
```

Execute this code and error.

```common-lisp
(error 1)
```

Output lisp implementation, loaded libraries and some information to standard output.

```common-lisp
{"cl-tasukete":[{"condition":"#<SIMPLE-TYPE-ERROR expected-type: SB-KERNEL::CONDITION-CLASS datum: 1>"},{"time":"2016-01-31T13:29:48.000000+09:00"},{"machine":{"INSTANCE":"vaio","TYPE":"X86-64","VERSION":"Intel(R) Core(TM) i5-4210U CPU @ 1.70GHz"}},{"operating-system":{"TYPE":"Linux","VERSION":"3.19.0-42-generic"}},{"lisp-implementation":{"TYPE":"SBCL","VERSION":"1.3.1"}},{"loaded-packages":[{"asdf":"3.1.5"},{"quicklisp":"20160121"},{"sb-bsd-sockets":[]},{"sb-introspect":[]},{"sb-cltl2":[]},{"cl-tasukete":"0.1"},{"cl-gists":"0.1"},{"cl-syntax":"0.3"},{"trivial-types":"0.1"},{"named-readtables":"0.9"},{"cl-syntax-annot":"0.2"},{"cl-annot":"0.1"},{"alexandria":"0.0.0"},{"local-time":"1.0.6"},{"cl-fad":"0.7.3"},{"sb-posix":[]},{"bordeaux-threads":"0.8.4"},{"quri":"0.1.0"},{"babel":[]},{"trivial-features":[]},{"split-sequence":"1.2"},{"cl-utilities":[]},{"sb-rotate-byte":[]},{"dexador":"0.9.10"},{"usocket":"0.6.3.2"},{"fast-http":"0.2.0"},{"proc-parse":"0.1"},{"xsubseq":"0.1"},{"smart-buffer":"0.1"},{"flexi-streams":"1.0.15"},{"trivial-gray-streams":"2.0"},{"uiop":"3.1.5"},{"fast-io":"1.0"},{"static-vectors":"1.6"},{"cffi-grovel":[]},{"cffi":"0.16.1"},{"chunga":"1.1.6"},{"cl-ppcre":"2.0.11"},{"cl-cookie":"0.1"},{"trivial-mimes":"1.1.0"},{"chipz":"0.8"},{"cl-base64":"3.1"},{"cl-reexport":"0.1"},{"cl+ssl":[]},{"trivial-garbage":[]},{"jonathan":"0.1"},{"dissect":"0.11.0"}]},{"stack":["#<DISSECT::SBCL-CALL [1] (LAMBDA ())>","#<DISSECT::SBCL-CALL [2] MAKE-DEBUG-INFORMATION | /home/user/cl-tasukete/src/cl-tasukete.lisp:103>","#<DISSECT::SBCL-CALL [3] TASUKETE | /home/user/cl-tasukete/src/cl-tasukete.lisp:133>","#<DISSECT::SBCL-CALL [4] RUN-HOOK>","#<DISSECT::SBCL-CALL [5] INVOKE-DEBUGGER>","#<DISSECT::SBCL-CALL [6] ERROR>","#<DISSECT::SBCL-CALL [7] ALLOCATE-CONDITION>","#<DISSECT::SBCL-CALL [8] MAKE-CONDITION>","#<DISSECT::SBCL-CALL [9] ERROR>","#<DISSECT::SBCL-CALL [10] SIMPLE-EVAL-IN-LEXENV>","#<DISSECT::SBCL-CALL [11] EVAL>","#<DISSECT::SBCL-CALL [12] EVAL-REGION | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp:1380>","#<DISSECT::SBCL-CALL [13] (LAMBDA () IN REPL-EVAL) | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/contrib/swank-repl.lisp>","#<DISSECT::SBCL-CALL [14] TRACK-PACKAGE | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/contrib/swank-repl.lisp:283>","#<DISSECT::SBCL-CALL [15] CALL-WITH-RETRY-RESTART | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp:488>","#<DISSECT::SBCL-CALL [16] CALL-WITH-BUFFER-SYNTAX | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp:1380>","#<DISSECT::SBCL-CALL [17] REPL-EVAL | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/contrib/swank-repl.lisp:270>","#<DISSECT::SBCL-CALL [18] SIMPLE-EVAL-IN-LEXENV>","#<DISSECT::SBCL-CALL [19] EVAL>","#<DISSECT::SBCL-CALL [20] EVAL-FOR-EMACS | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp:990>","#<DISSECT::SBCL-CALL [21] PROCESS-REQUESTS | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp:885>","#<DISSECT::SBCL-CALL [22] (LAMBDA () IN HANDLE-REQUESTS) | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp>","#<DISSECT::SBCL-CALL [23] (LAMBDA () IN HANDLE-REQUESTS) | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp>","#<DISSECT::SBCL-CALL [24] CALL-WITH-BREAK-HOOK | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank/sbcl.lisp:923>","#<DISSECT::SBCL-CALL [25] (FLET CALL-WITH-DEBUGGER-HOOK IN /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank/sbcl.lisp) | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank/sbcl.lisp>","#<DISSECT::SBCL-CALL [26] CALL-WITH-BINDINGS | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp:55>","#<DISSECT::SBCL-CALL [27] HANDLE-REQUESTS | /home/user/.emacs.d/.cask/24.4.1/elpa/slime-20160113.630/swank.lisp:873>","#<DISSECT::SBCL-CALL [28] (FLET WITHOUT-INTERRUPTS-BODY-1156 IN INITIAL-THREAD-FUNCTION-TRAMPOLINE)>","#<DISSECT::SBCL-CALL [29] (FLET WITH-MUTEX-THUNK IN INITIAL-THREAD-FUNCTION-TRAMPOLINE)>","#<DISSECT::SBCL-CALL [30] (FLET WITHOUT-INTERRUPTS-BODY-359 IN CALL-WITH-MUTEX)>","#<DISSECT::SBCL-CALL [31] CALL-WITH-MUTEX>","#<DISSECT::SBCL-CALL [32] INITIAL-THREAD-FUNCTION-TRAMPOLINE>","#<DISSECT::SBCL-CALL [33] foreign function: call_into_lisp>","#<DISSECT::SBCL-CALL [34] foreign function: new_thread_trampoline>"]}]}
```

If you stop cl-tasukete

```common-lisp
(tasukete:stop)
```

## Input source

* condition
* time
* package
* machine type
* operating system type
* loaded packages and versions
* stack trace

## Output source

* standard output
* public gists

## Unittest

```common-lisp
(ql:quickload :cl-tasukete)
(asdf:test-system :cl-tasukete)
```

## Author

* gos-k (mag4.elan@gmail.com)

## License

```
Copyright (c) 2015 gos-k (mag4.elan@gmail.com)
Licensed under the MIT License.
http://opensource.org/licenses/mit-license.php
```
