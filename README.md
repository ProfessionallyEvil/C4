# C4
**C**yberdelia, a **C**ollection of **C**ommand and **C**ontrol frameworks

<p align="center">
  <a href="https://professionallyevil.slack.com/messages/c4"> <img alt="Slack" src="https://img.shields.io/badge/chat-ProfessionallyEvil-%238c0000.svg?logo=slack" /></a>
  <a href="https://github.com/SamuraiWTF/samuraiwtf/releases"> <img alt="GitHub tag (latest SemVer pre-release)" src="https://img.shields.io/github/v/tag/ProfessionallyEvil/C4?include_prereleases&sort=semver&label=release" /></a>
  <a href="https://github.com/ProfessionallyEvil/C4/blob/master/LICENSE" > <img alt="License" src="https://img.shields.io/badge/license-GPLv3-blue.svg" /></a>
  <a href="https://github.com/ProfessionallyEvil/C4"><img alt="GitHub stars" src="https://img.shields.io/github/stars/ProfessionallyEvil/C4?style=social"></a>
</p>

## Table of Contents

- [C4](#c4)
  - [Table of Contents](#table-of-contents)
  - [What is this?](#what-is-this)
  - [Cyberdelia?](#cyberdelia)
    - [What is a C2 (framework)?](#what-is-a-c2-framework)
  - [Why create this repo?](#why-create-this-repo)
  - [Format](#format)
    - [Plan for this repo](#plan-for-this-repo)
    - [Github Specific content](#github-specific-content)
      - [Contribute to project](#contribute-to-project)
        - [Resources used for github repo](#resources-used-for-github-repo)

## What is this?

This is a very fluid (as in continuously changing) github repo that will do comparisons of prominent Command and Control (C2) frameworks in the red team/pentesting industry.

## Cyberdelia?

Cyberdelia is a place from the movie [Hackers](https://m.imdb.com/title/tt0113243/) that all the main actors would go to meetup and hangout. While there, they would trade tips, tricks, and knowledge about their trade, which is what I hope this repo will be.

<div align="center">
<a href="http://www.youtube.com/watch?feature=player_embedded&v=4U9MI0u2VIE" target="_blank"><img src="https://img.youtube.com/vi/4U9MI0u2VIE/0.jpg" alt="Hacker - Crayola Books Scene"  /></a>
<a href="http://www.youtube.com/watch?feature=player_embedded&v=hR62mcMJ2pE" target="_blank"><img src="https://img.youtube.com/vi/hR62mcMJ2pE/0.jpg" alt="Hacker - Phone Scene"  /></a>
</div>
<br>

### What is a C2 (framework)?

Rather than try and explain everything about what a C2 is, just checkout this YouTube video. @monoxgas gives an in depth explaination about what a C2 is and what it should do during his talk [Flying a False Flag](https://github.com/monoxgas/FlyingAFalseFlag)

<div align="center">
<a href="http://www.youtube.com/watch?feature=player_embedded&v=2BEwqbCbQuM&t=136" target="_blank"><img src="https://img.youtube.com/vi/2BEwqbCbQuM/0.jpg" alt="Flying a false flag"  /></a>
</div>

Command-and-control servers, also called C&C or C2, are used by attackers and/or threat actors to maintain contact and communications with compromised systems within a target network. Ref: [Intro to Red Team](https://blog.zsec.uk/redteam-intro/) 

## Why create this repo?

For a long time Powershell Empire was known as the standard for open-source C2 frameworks, and since they have now discontinued the project this repo will be a landing for others to keep track of new frameworks.

<div align="center">
  <a href="https://twitter.com/xorrior/status/1156626181107736576"><img style="width: 60%;" alt="xorrior twitter empire dead" src="https://i.imgur.com/dWJULLw.png"></a>
</div>


## Format

_**note:** for a comprehensive list of all the C2 frameworks we will cover here please visit the [frameworks folder](/frameworks/)._

This format/layout is absolutly subject to change, and if you think there is a better way to present this content please message me in the [Professionally Evil Slack](https://professionallyevil.slack.com/messages/c4).
I am gathering all this information to try and help compare and contrast the strong and weak points of different C2 frameworks, so whatever helps the presentation of that material the better!
This repo will try to have releases, to better help solidfy when content is better solidified for consumtion, but it will not have Development Stages (i.e. alpha, beta, etc...) in release tags since the information is constantly evolving (unless someone thinks it should, and tell me how they think it should work).

### Plan for this repo

Hopefully this repo can be similar to an [awesome list](https://github.com/topics/awesome), but be better in that we can aggregate video reviews of C2 frameworks, comparison points, and best use cases for when to use specific C2 frameworks.
Currently the plan will be that I get the current list of C2 frameworks figured out for a v0.1.0 release, and I would love community help in making sure all information is accurate and informative!

### Github Specific content

All github specific content is in the [.github](/.github/) folder. (i.e. Code of Conduct, Contributing Guidelines, etc...)

#### Contribute to project

If you would like to submit a contribution (i.e. correction, improvement, or alteration) to the project checkout the [CONTRIBUTING.md](/.github/CONTRIBUTING.md)


##### Resources used for github repo

- Github support/help
  - https://help.github.com/en/articles/creating-a-default-community-health-file-for-your-organization
  - https://github.community/t5/Support-Protips/Best-practices-for-pull-requests/ba-p/4104
  - https://help.github.com/en/articles/about-github-actions
  - https://help.github.com/en/articles/configuring-a-workflow
- others
  - https://github.com/gobuffalo/buffalo/blob/master/CODE_OF_CONDUCT.md 
  - https://github.com/trailofbits/algo/blob/master/PULL_REQUEST_TEMPLATE.md
