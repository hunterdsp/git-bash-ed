
[comment]: # (START FRONTMATTER - USER CONTENT BELOW)

[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit)
](https://github.com/pre-commit/pre-commit)
[![Jenkins](https://img.shields.io/badge/CI%20%2F%20CD-Jenkins-lightgray?logo=jenkins)
](https://jenkins.core-services.e3.aero.org/job/csad/job/git-bash-ed/)
[![Nexus](https://img.shields.io/badge/repository-releases-green?logo=sonatype&logoColor=green)
](https://nexus.core-services.e3.aero.org/service/rest/repository/browse/csad-raw-public/csad/git-bash-ed/)
[![Quality Gate Status](https://sonarqube.core-services.e3.aero.org/api/project_badges/measure?project=csad.git-bash-ed.master&metric=alert_status&token=sqb_96a9efb7ad878396383c8e162225132dd7c59718)
](https://sonarqube.core-services.e3.aero.org/dashboard?id=csad.git-bash-ed.master)

[![GNU Bash](https://cdn.rawgit.com/odb/official-bash-logo/master/assets/Logos/Identity/PNG/BASH_logo-transparent-bg-color.png)
](https://www.gnu.org/software/bash/)

[comment]: # (END FRONMATTER - BEGIN USER CONTENT)

# Git-BA$H-Ed

Evolving set of [shfmt](https://github.com/mvdan/sh#shfmt)-conformant, [bats](https://bats-core.readthedocs.io/en/stable/)-tested, [shellcheck](https://www.shellcheck.net/)-linted tools, templates, and more.

## Getting Started

A release package contains shell libraries along with a script and two function templates for developing your own tools.

```
git-bash-ed
    +--README.md
    +--src/
    |   +-- datetime.sh
    |   +-- environment.sh
    :   :
    |   +-- function-template.sh
    |   +-- script-template
    +--test-results/
```

Some libraries depend on others so it's best to just use the whole package and source whatever you need, for example:

```bash
. git-bash-ed/src/datetime.sh # contains iso-8601-basic()
iso-8601-basic -d '10:32 AM EDT Jan 5 1982'
19820105T143200Z
```

No installation required, simply [download](https://nexus.core-services.e3.aero.org/service/rest/repository/browse/csad-raw-public/csad/git-bash-ed/) and use!

## Feedback and Contribution Welcome!

matthew.t.hunter@aero.org.
