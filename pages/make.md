# Make as a general purpose task runner
Lately, I've become more and more of a fan of
using a Makefile as the main entrypoint for running
development tasks of software projects, both personal
and professional. Here are some of the main reasons
and examples.


## Background
### * What is Make?
Make is a command line tool, typically used
for compilation related tasks. It first appeared in 1976,
is now standardized in POSIX, and is ubiquitous on almost
any Unix like system. C and C++ programmers are likely
familiar with it. Today I want to demonstrate that
it is general purpose enough to be used for almost any
task in a software project.

## Why use Make?
### * Always up to date
If collaborators use a Makefile to drive the tasks they run,
there's no doubt that it will remain up to date with the
latest ways to build, run, test, and lint the project.
As software projects evolve, one may rotate through several
combinations of task runners and arguments passed to
those task runners. As these tasks change, the Makefile is
updated to reflect these, ensuring that all collaborators
are aware of and using the most up to date commands or options
to build the project.

### * Self documenting
A Makefile acts as both the configuration for Make, and as
a primary documentation source for the commands that are used
to run the project. If there is a Make target called 'build',
one can reasonably assume that it is the command used to build
the project.

The alternative of maintaining a set of commands in a README or
other documentation often results in a document that is not often consulted
by team members with longer tenures, and thus falls out of date
when changes occur. These changes are then communicated as
tribal knowledge, or sometimes not at all.

When using a Makefile, the README or other onboarding documentation
can simply direct users to the Makefile, where they can see all
of the current commands.

### * Enforce consistent usage
A common source of inconsistencies in development can come
from team members using slightly different commands or parameters
to build their projects locally. The Yarn vs NPM vs pnpm package
managers are great examples of this: they all operate from the
same package specification file (package.json), but can produce
different dependency resolutions from the same input. Using a
Makefile ensures that each team member is using the same set of
commands.

### * Uniform interface across heterogenous projects
Even if different software projects in an organization
use different languages, frameworks, or build tools, a Makefile
can act as a uniform interface to these systems. Users can
examine a Makefile for simple targets like 'build', 'test', 'lint',
'dev', and quickly know what they do. A project ultimately
built with NPM can be run in dev mode with the same command as
a project built with Gradle, if they have the same targets pointing
to the appropriate commands in the respective build system.

### * Simple expression of dependencies
Make targets can express their dependencies in a simple way.
This allows for composition and reduces the need for repetition.
For example, you may want to ensure that the compilation output
directory is clean before building. If there is a 'clean' target,
it can be run independently, and also included as a dependency of
the 'build' target

### * Preinstalled on most systems
Almost all Unix like systems, including Linux, BSD, and macOS,
come with Make preinstalled, so it can be used right away without
having to install from a package manager.

## Examples
Let's see a quick example. This is an example Makefile for
a project built with yarn:

<pre>
.PHONY: dev
dev:
	yarn dev

.PHONY: test
test:
	yarn test

.PHONY: build
build: test
	yarn build
</pre>

Ultimately, it's not that interesting. Three targets that essentially
delegate the same command to yarn. But consider the points above: it
enforces a uniform package manager (yarn), and remains up to date when
anything needs to change. It also specifies that test is a dependency
of build. We also use `.PHONY` to indicate that the target names are
not referencing output files that should be checked, and that the
command should always be run no matter what.

Here's an example for a Quarkus project built with Maven:
<pre>
.PHONY: dev
dev:
	./mvnw quarkus:dev

.PHONY: test
test:
	./mvnw test

.PHONY: build
build:
	./mvnw package -Dnative

.PHONY: docker-build
docker-build: build
	docker build -t my_app -f ./src/main/docker/Dockerfile.native
</pre>

With this one, some of the other benefits become clear:
Maven POM files do not have an easily discoverable set
of targets that show how to build a project. We also
use a target (docker-build) which doesn't use Maven at
all, but depends on the output of a Maven target.

Also consider with these examples combined, a developer can
be familiar with the general targets used throughout an
organization's ecosystem (dev, test, build) so that it feels
less like context switching and more like running the same
types of projects, even when using a different language
or underlying build system.

Hope you found this interesting and consider using Make to
self document the commands for developing your project!
