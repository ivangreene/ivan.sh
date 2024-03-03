# Make as a general purpose task runner
Lately, I've become more and more of a fan of
using a Makefile as the main entrypoint for running
development tasks of software projects, both personal
and professional. Here are some of the main reasons
and examples.

## Background
### What is `make`?
Make is a command line tool, typically used
for compilation related tasks. It first appeared in 1976,
is now standardized in POSIX, and is ubiquitous on almost
any Unix like system. C and C++ programmers are likely
familiar with it. But today I want to demonstrate that
it is general purpose enough to be used for almost any
task in a software project.

As software projects evolve, one may rotate through several
combinations of task runners, arguments passed to
those task runners
