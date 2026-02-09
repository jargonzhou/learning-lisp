# Leiningen
* https://leiningen.org/
* https://github.com/technomancy/leiningen
* https://codeberg.org/leiningen/leiningen

> Leiningen is for automating Clojure projects without setting your hair on fire.

```shell
# $ sdk install leiningen

# add 'set LEIN_HOME=D:\software\bin\.lein' to lein.bat
$ lein.bat self-install
$ lein version
Leiningen 2.12.0 on Java 1.8.0_461 Java HotSpot(TM) Client VM
```

# Tutorial
* https://leiningen.org/tutorial.html
* https://leiningen.org/faq.html
* [sample.project.clj](https://github.com/technomancy/leiningen/blob/main/sample.project.clj)

project-related tasks:
- create new projects
- fetch dependencies for your project
- run tests
- run a fully-configured REPL
- compile Java sources (if any)
- run the project (if the project isn’t a library)
- generate a maven-style “pom” file for the project for interop
- compile and package projects for deployment
- publish libraries to repositories such as Clojars
- run custom automation tasks written in Clojure (leiningen plug-ins)

```shell
$ lein help
Leiningen is a tool for working with Clojure projects.

Several tasks are available:
change              Rewrite project.clj by applying a function.
check               Check syntax and warn on reflection.
classpath           Print the classpath of the current project.
clean               Remove all files from project's target-path.
compile             Compile Clojure source into .class files.
deploy              Build and deploy jar to remote repository.
deps                Download and examine dependencies./下载和检查依赖
do                  Higher-order task to perform other tasks in succession.
help                Display a list of tasks or help for a given task./帮助
install             Install the current project to the local repository.
jar                 Package up all the project's files into a jar file.
javac               Compile Java source files.
new                 Generate project scaffolding based on a template./创建项目
plugin              DEPRECATED. Please use the :user profile instead.
pom                 Write a pom.xml file to disk for Maven interoperability.
release             Perform :release-tasks.
repl                Start a repl session either with the current project or standalone.
retest              Run only the test namespaces which failed last time around.
run                 Run a -main function with optional command-line arguments.
search              Search Central and Clojars for published artifacts./搜索依赖仓库
show-profiles       List all available profiles or display one if given an argument.
static-classpath    Print the classpath of the current project without loading code.
test                Run the project's tests.
trampoline          Run a task without nesting the project's JVM inside Leiningen's.
uberjar             Package up the project files and dependencies into a jar file.
update-in           Perform arbitrary transformations on your project map.
upgrade             Upgrade Leiningen to specified version or latest stable.
vcs                 Interact with the version control system.
version             Print version for Leiningen and the current JVM.
with-profile        Apply the given task with the profile(s) specified.

Run `lein help $TASK` for details.

$ lein help tutorial
$ lein help faq
$ lein help sample
```

creating a project
```shell
$ lein help new
Subtasks available:
template   A meta-template for 'lein new' templates.
plugin     A leiningen plugin project template.
default    A general project template for libraries.
app        An application project template.

lein new $TEMPLATE_NAME $PROJECT_NAME
lein new :show $TEMPLATE
lein help templates
# Third-party templates: https://clojars.org/search?q=artifact-id:lein-template
```

Leiningen by default will use two of them: clojars.org and Maven Central.
- [Clojars](https://clojars.org/) is the Clojure community’s centralized Maven repository
- Maven Central is for the wider JVM community.

environments
```shell
export LEIN_JVM_OPTS="-Dmaven.wagon.rto=1800000"
```

running code
```shell
$ lein repl
ex-lein.core=> (require 'ex-lein.core)
nil
ex-lein.core=> (ex-lein.core/-main)
Hello, World!
nil
ex-lein.core=> (require '[clj-http.client :as http])
nil
ex-lein.core=> (def response (http/get "https://leiningen.org"))
#'ex-lein.core/response
ex-lein.core=> (keys response)
(:cached :request-time :repeatable? :protocol-version :streaming? :http-client :chunked? :reason-phrase :headers :orig-content-encoding :status :length :body :trace-redirects)      
ex-lein.core=> (:status response)
200
ex-lein.core=>
```

inspect source and doc
```shell
ex-lein.core=> (doc -main)
-------------------------
ex-lein.core/-main
([& args])
  I don't do a whole lot ... yet.
nil
ex-lein.core=> (source -main)
(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!"))
nil
ex-lein.core=> 
```
```shell
# Providing a -m argument will tell Leiningen to look for the -main function in another namespace. Setting a default :main in project.clj lets you omit -m.
$ lein run
Hello, World!
```

tests
```shell
# The built-in test command wraps the basic runner from `clojure.test` and adds a few small features, but many people prefer to replace it with a more full-featured test runner like `kaocha`. 
$ lein test

lein test ex-lein.core-test

lein test :only ex-lein.core-test/a-test

FAIL in (a-test) (core_test.clj:7)
FIXME, I fail.
expected: (= 0 1)
  actual: (not (= 0 1))

Ran 1 tests containing 1 assertions.
1 failures, 0 errors.
Subprocess failed (exit code: 1)
```

build
- Uberjar: This is a single standalone executable jar file most suitable for giving to nontechnical users. For this to work you’ll need to specify a namespace as your `:main` in `project.clj` and ensure it’s also AOT (Ahead Of Time) compiled by adding it to `:aot`.
- Framework (Uber)jars: The framework expects to provide the missing dependencies itself at run-time. Dependencies which are provided by a framework in this fashion may be specified in the `:provided` profile.
- Server-side Projects: lein-tar plugin, lein-ring plugin, `lein trampoline run`.
```shell
$ lein uberjar

# publish
$ lein deploy clojars
```

# `project.clj`
* [sample.project.clj](./sample.project.clj)

# Profiles
* https://leiningen.org/profiles.html

> TODO

Profiles are used to add various things into your project map in different contexts. For instance, during `lein test` runs, the contents of the `:test` profile, if present, will be merged into your project map. You can use this to enable configuration that should only be applied during test runs, either by adding directories containing config files to your classpath via `:resource-paths` or by other means. See `lein help profiles` for more details.

Unless you tell it otherwise, Leiningen will merge the default set of profiles into the project map. This includes user-wide settings from your `:user` profile, the `:dev` profile from `project.clj` if present, and the built-in `:base` profile which contains dev tools like nREPL and optimizations which help startup time at the expense of runtime performance. Never benchmark with the default profiles. (See the FAQ entry for “tiered compilation”)

``` shell
$ lein help profiles
```

You can change the configuration of your project by applying various profiles. For instance, you may want to have a few extra test data directories on the classpath during development without including them in the jar, or you may want to have development tools like [Slamhound](https://github.com/technomancy/slamhound) available in every project you hack on without modifying every single `project.clj` you use.

You can place any arbitrary key/value pairs supported by `defproject` into a given profile and they will be merged into the project map when that profile is activated.

The example below adds a "dummy-data" resources directory during development and a dependency upon "expectations" that's only used for tests/development.

```clj
(defproject myproject "0.5.0-SNAPSHOT"
  :description "A project for doing things."
  :dependencies [[org.clojure/clojure "1.4.0"]]
  :profiles {:dev {:resource-paths ["dummy-data"]
                   :dependencies [[expectations "1.4.41"]]}})
```

Use the `show-profiles` task to list the project's profiles.

## Declaring Profiles

In addition to `project.clj`, profiles also can be specified in `profiles.clj` within the project root. Profiles specified in `profiles.clj` will override profiles in `project.clj` (via [merging](#merging) logic described below), so this can be used for project-specific overrides that you don't want committed in version control.

User-wide profiles can also be specified in `~/.lein/profiles.clj`. These will be available in all projects managed by Leiningen, though those profiles will be overridden by profiles of the same name specified in the project.  System-wide profiles can be placed in `/etc/leiningen/profiles.clj`. They are treated the same as user profiles, but with lower precedence.

You can also define user-wide profiles within `clj`-files inside `~/.lein/profiles.d`. The semantics within such files differ slightly from other profile files: rather than a map of maps, the profile map is the top-level within the file, and the name of the profile comes from the file itself (without the `.clj` part). Defining the same user-wide profile in both `~/.lein/profiles.clj` and in `~/.lein/profiles.d` is considered an error.

## Default Profiles

Certain profiles are active by default unless you specify another set of profiles using the `with-profile` task. Each of the default profiles have different semantics:

If you want to access dependencies or plugins during development time for any project place them in your `:user` profile. Your `~/.lein/profiles.clj` file could look something like this:

```clj
{:user {:plugins [[lein-pprint "1.1.1"]]
        :dependencies [[slamhound "1.3.1"]]}}
```

The `:dev` profile is used to specify project specific development tooling. Put things here if they are required for builds or tests, rather than just convenience tooling.

The `:user` profile is separate from `:dev`; the latter is intended to be specified in the project itself. In order to avoid collisions, the project should never define a `:user` profile, nor should a user-wide `:dev` profile be defined.  Likewise, system profiles should use the `:system` profile, and define neither `:user` nor `:dev` profiles.

The `:system` profile is similar to `:user`, except it applies system-wide instead of merely to a single user.

The `:base` profile provides dependencies necessary for basic repl functionality, adds `dev-resources` to the `:resource-paths`, and sets defaults for `:jvm-opts`, `:checkout-deps-share` and `:test-selectors`. It is part of Leiningen itself; you shouldn't need to change it.

The profiles listed above are active during development, but they are unmerged before the jar and pom files are created, making them invisible to code that depends upon your project.

The `:provided` profile is used to specify dependencies that should be available during jar creation, but not propagated to other code that depends on your project. These are dependencies that the project assumes will be provided by whatever environment the jar is used in, but are needed during the development of the project. This is often used for frameworks like Hadoop that provide their own copies of certain libraries.

The `:default` profile specifies the profiles that are active by default when running lein tasks.  If not overridden, this is set to `:leiningen/default`, which is a composite profile with `[:base :system :user :provided :dev]`.

## Task Specific Profiles

Some tasks automatically merge a profile if specified.  Examples of these are the `:test` profile, when running the `test` task, and the `:repl` profile, when running the `repl` task. Please note that putting things in the `:test` profile is strongly advised against as it can result in tests which can't be run from the repl.

## Profile Metadata

If you mark your profile with `^:leaky` metadata, then the profile will not be stripped out when the pom and jar files are created.

If you mark a profile with `^{:pom-scope :test}` metadata, then the profile's `:dependencies` will be added with a `test` scope in the generated pom and jar when active. The `:dev`, `:test`, and `:base` profiles have this set automatically.

If you mark a profile with `^{:pom-scope :provided}` metadata, then the profile's `:dependencies` will be added with a `provided` scope in the generated pom and jar when active. The `:provided` profile has this set automatically.

## Merging

Profiles are merged by taking each key in the project map or profile map, combining the value if it's a collection and replacing it if it's not. Profiles specified later take precedence when replacing, just like the `clojure.core/merge` function. The dev profile takes precedence over user by default. Maps are merged recursively, sets are combined with `clojure.set/union`, and lists/vectors are concatenated. You can add hints via metadata that a given value should take precedence (`:replace`) or defer to values from a different profile (`:displace`) if you want to override this logic:

```clj
{:profiles {:dev {:prep-tasks ^:replace ["clean" "compile"]
                  :aliases ^:displace {"launch" "run"}}}}
```

The exception to this merge logic is that `:plugins` and `:dependencies` have custom de-duplication logic since they must be specified as vectors even though they behave like maps (because it only makes sense to have a single version of a given dependency present at once). The replace/displace metadata hints still apply though.

Remember that if a profile with the same name is specified in multiple locations, only the profile with the highest "priority" is picked – no merging is done. The "priority" is – from highest to lowest – `profiles.clj`, `project.clj`, user-wide profiles, and finally system-wide profiles.

If you need to enable personal overrides of parts of a profile, you can use a composite profile with common and personal parts - something like `:dev [:dev-common :dev-overrides]`; you would then have just `:dev-overrides {}` in `project.clj` and override it in `profiles.clj`.

Another use of profiles is to test against various sets of dependencies:

```clj
(defproject swank-clojure "1.5.0-SNAPSHOT"
  :description "Swank server connecting Clojure to Emacs SLIME"
  :dependencies [[org.clojure/clojure "1.2.1"]
                 [clj-stacktrace "0.2.4"]
                 [cdt "1.2.6.2"]]
  :profiles {:1.3 {:dependencies [[org.clojure/clojure "1.3.0"]]}
             :1.4 {:dependencies [[org.clojure/clojure "1.4.0-beta1"]]}})
```

## Activating Profiles

To activate a different set of profiles for a given task, use the `with-profile` higher-order task:

```shell
$ lein with-profile 1.3 test :database
```

Multiple profiles may be combined with commas:

```shell
$ lein with-profile qa,user test :database
```

Multiple profiles may be executed in series with colons:

```shell
$ lein with-profile 1.3:1.4 test :database
```

The above invocations activate the given profiles in place of the defaults. To activate a profile in addition to the defaults, prepend it with a `+`:

```shell
$ lein with-profile +server run
```

You can also use `-` to deactivate a profile.

By default all profiles will share the same `:target-path`, which can cause problems if settings from one profile leak over into another. It's recommended to set `:target-path` to `"target/%s"`, which will isolate each profile set and prevent anything from bleeding over.

## Composite Profiles

Sometimes it is useful to define a profile as a combination of other profiles. To do this, just use a vector instead of a map as the profile value.
This can be used to avoid duplication:

```clj
{:shared {:port 9229, :protocol "https"}
 :qa-servers {:servers ["qa.mycorp.com"]}
 :prod-servers {:servers ["prod1.mycorp.com", "prod1.mycorp.com"]}
 :qa [:shared :qa-servers]
 :production [:shared :prod-servers]}
```

It is not recommended to make a composite profile which contains both keywords and maps; they should either be all keywords or all maps.

Composite profiles also cannot have certain types of metadata propagated, which makes them incompatible with the `:provided` profile. If you get the error "Composite profiles are incompatible with :provided." consider adding `^{:pom-scope :provided}` metadata to the profile map which contains the dependencies instead.

## Dynamic Eval

Often you want to read an environment variable or execute a function to capture a value to use in your profiles. In order to do such a thing with the profiles.clj you'll need to use the read-eval syntax.

Here is an example of such a case:

```clj
{:user {:compile-path  #=(eval (System/getenv "ci.compile-path")),
        :target-path #=(eval (System/getenv "ci.target-path"))}}
```

## Debugging

To see how a given profile affects your project map, use the [lein-pprint](https://codeberg.org/leiningen/leiningen/src/stable/lein-pprint) plugin:

```shell
$ lein with-profile 1.4 pprint
{:compile-path "/home/phil/src/leiningen/lein-pprint/classes",
 :group "lein-pprint",
 :source-path ("/home/phil/src/leiningen/lein-pprint/src"),
 :dependencies
 ([nrepl "0.8.3" :exclusions [org.clojure/clojure]]
  [incomplete "0.1.0" :exclusions [org.clojure/clojure]]
  [org.thnetos/cd-client "0.3.3" :exclusions [org.clojure/clojure]]),
 :target-path "/home/phil/src/leiningen/lein-pprint/target",
 :name "lein-pprint",
 [...]
 :description "Pretty-print a representation of the project map."}
```

In order to prevent profile settings from being propagated to other projects that depend upon yours, the `:default` profiles are removed from your project when generating the pom, jar, and uberjar, and an `:uberjar` profile, if present, is included when creating uberjars. (This can be useful if you want to specify a `:main` namespace for uberjar use without triggering AOT during regular development.) Profiles activated through an explicit `with-profile` invocation will be preserved.

# Plugins
* https://leiningen.org/plugins.html
* https://wiki.leiningen.org/Plugins


plugins:
* [lein-jib-build](https://github.com/vehvis/lein-jib-build): Build docker containers with Leiningen, no docker installation needed. Uses Google's Jib toolkit.

# Deploy
* https://leiningen.org/deploy.html

# Leiningen Core
* https://github.com/technomancy/leiningen/tree/github/leiningen-core

This library provides the core functionality of Leiningen. This consists of the task execution implementation, project configuration, and helper functions. The built-in tasks and the launcher scripts are kept in the main `leiningen` project.

# See Also
* [test-refresh](https://github.com/jakemcc/test-refresh): This is a Clojure tool that notices when your source changes and then reloads your code and runs your `clojure.test` tests. It works with Leiningen and `deps.edn` based projects.
