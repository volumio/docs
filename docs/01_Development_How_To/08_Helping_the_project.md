## Helping the project

Even if you are not interested writing new code, you can make a significant
contribution to the project in other ways.

### Reporting Issues

If you find a problem with Volumio, the best way to get it fixed is to
open a issue on Github. This ensures the development community won't
forget about it. Remember though, this is a system for remembering things to do,
not a discussion forum. Sometimes it's better to start a forum thread and
link to the issue (or vice versa).

Before opening an issue, gather some information about the problem
so that someone else can try to reproduce it on their Volumio system.

 * Your system version (this comes in very handy if the issue takes a while
   to resolve - the 'current' version will be significantly different when
   someone comes along to look at it)
 * Does it happen all the time or intermittently?
   This is important - sometimes if you wait and try again, the problem may
   just go away.
 * Did you find a workaround? If so, what was it? This can help other users
   and may provide useful clues to the developers
 * Does it happen with all types of media, or just some?
 * Does it happen when you are using a plugin ?
   What happens if you disable the plugin temporarily?

Note that there is more than one issue tracker, so consider where you
think the problem lies before opening your issue.

 * The backend - [https://github.com/volumio/Volumio2/issues](https://github.com/volumio/Volumio2/issues)
 * The web interface - [https://github.com/volumio/Volumio2-UI/issues](https://github.com/volumio/Volumio2-UI/issues)
 * A plugin - [https://github.com/volumio/volumio-plugins/issues](https://github.com/volumio/volumio-plugins/issues)
 * The documentation - [https://github.com/volumio/docs/issues](https://github.com/volumio/docs/issues)
 * Somewhere in your volumio system outside the `/volumio` directory -
   [https://github.com/volumio/Build/issues](https://github.com/volumio/Build/issues).

A very useful thing to do when submitting an issue is to capture a debug log
[Sending logs for troubleshooting](../User_Manual/Sending_logs_for_troubleshooting.html).
This provides a lot of extra information the developers can use to isolate the problem.

### Reviewing Issues

There are lots of existing issues in the project and helping to sift through
them can be a valuable contribution.

 * Try to reproduce the issue.
   * If you can, add a comment to the issue explaining what you did,
     what happened, what you expected to happen, etc.
   * If you cannot reproduce it, that is useful information too.
     You should make sure to say what your volumio version is - if it is newer
     than the one in the original report that means it's probably fixed, but if
     it's older, that gives a good starting point to find the change that caused
     the problem.
 * If you need more information to be able to try to reproduce the issue,
   you could add a comment asking the submitter for missing information.
 * Cross-reference duplicate issues.
   If you think two issues are the same problem, add a comment to the newer one
    * reference the older issue e.g. `issue #123`
    * explain why you think they are the same
 * Testing a fix.
   If someone proposes a fix in a pull request, you could try applying it and
   uploading it to your Volumio.
    * Make sure you have a fork on github of the project the fix is for
    * Clone that locally, e.g.
    ```shell
    $ git clone https://github.com/joeschmoe128/Volumio2.git
    $ cd Volumio2
    ```
    * Add the repository where the fix is coming from as an extra remote
    ```shell
    $ git add remote proposer https://github.com/futh9iN8/Volumio2.git
    $ git fetch proposer
    ```
    * Try to merge the branch from that remote that has the fix
    ```shell
    $ git checkout -t proposer/newcoolfix
    $ git checkout master
    $ git diff master upstream/master # make sure it's up to date
    $ git merge newcoolfix
      # if it fails to merge, you should add a comment on the PR
    ```
    * Upload the changed files to your Volumio device and test
    * Add comments to the issue, maybe add a `Tested-by:` tag if you like

### Translations

If you know more than one language you can help by keeping the translation
files up to date. It works like this: the
[Volumio2](https://github.com/github/Volumio2) and
[Volumio2-UI](https://github.com/github/Volumio2-UI) projects
have an `i18n` directory containing files named `strings_XX.json`.
Each `XX` is a two-digit language code.
Each file contains small pieces of text, that mean the same thing in each language.
For example in `strings_en.json` we have
```json
    "HELP":"Help",
```
The same line in `strings_it.json` reads
```json
    "HELP":"Aiuto",
```
If you see lines with no translation
```json
    "HELP":"",
```
perhaps you could add some of these and send a pull request.

### Being Patient

When you've reported or done some work on an issue, or sent a pull request,
it may take quite a while to get a response, particularly with pull requests.
Being patient is a helpful thing to do; it gives the person the time to deal
with whatever else they are doing, so they can get to your issue.
