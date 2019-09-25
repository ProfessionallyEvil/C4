#!/usr/bin/env bash

# normal
set -euo pipefail
# debug
# set -exuo pipefail

# "global" variables
script_dir="$(dirname "$(realpath "${0}")")"
project_root="${script_dir}/.."

markdown_blob=''

function gh_info(){
    # variables used in function
    github_user_array=()
    github_project_array=()
    github_array=()
    github_urls="${project_root}/misc/urls"

    if [[ $# -eq 0 ]] ; then
        mapfile -t github_array < <(grep github "${github_urls}" | grep -v '/Awesome' | rev | cut -d '/' -f -2 | rev)
    elif [[ $# -eq 1 ]] ; then
        mapfile -t github_array < <(grep github "${github_urls}" | grep -v '/Awesome' | grep "${1}" | rev | cut -d '/' -f -2 | rev)
    else
        printf 'I have not implemented that yet...no soup for you...'
        exit 1
    fi

    # creating gh arrays
    for github_string in "${github_array[@]}" ; do
        github_user_array+=("$(echo "${github_string}" | cut -d '/' -f 1)")
        github_project_array+=("$(echo "${github_string}" | cut -d '/' -f 2)")
    done
}

function gh_issues(){
    gh_issues_blob="\n#### Issues ( ${2} )\n"
    gh_issues_blob+="- issues open: [![GitHub issues](https://img.shields.io/github/issues/${1}/${2})](https://github.com/${1}/${2}/issues)\n"
    gh_issues_blob+="- issues closed: [![GitHub closed issues](https://img.shields.io/github/issues-closed/${1}/${2})](https://github.com/${1}/${2}/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aclosed)\n"
    gh_issues_blob+="- bugs open: [![GitHub issues bugs](https://img.shields.io/github/issues-raw/${1}/${2}/bug)](https://github.com/${1}/${2}/issues?q=is%3Aissue+is%3Aopen+label%3Abug)\n"
    gh_issues_blob+="- bugs closed: [![GitHub closed issues bugs](https://img.shields.io/github/issues-closed-raw/${1}/${2}/bug)](https://github.com/${1}/${2}/issues?q=is%3Aissue+is%3Aclosed+label%3Abug)\n"
    gh_issues_blob+="#### Pull Requests ( ${2} )\n"
    gh_issues_blob+="- pull requests open: [![GitHub pull requests](https://img.shields.io/github/issues-pr/${1}/${2})](https://github.com/${1}/${2}/pulls)\n"
    gh_issues_blob+="- pull requests closed: [![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/${1}/${2})](https://github.com/${1}/${2}/pulls?q=is%3Apr+is%3Aclosed)\n"

    markdown_blob+=$(echo -e "${gh_issues_blob}\n")
}

function gh_tagging(){
    gh_tagging_blob="\n#### Latest info ( ${2} )\n"
    gh_tagging_blob+="- latest release: [![GitHub (Pre-)Release Date](https://img.shields.io/github/release-date-pre/${1}/${2})](https://github.com/${1}/${2}/releases)\n"
    gh_tagging_blob+="- latest commit: [![GitHub last commit](https://img.shields.io/github/last-commit/${1}/${2})](https://github.com/${1}/${2}/commits/master)\n"
    gh_tagging_blob+="#### Tagged ( ${2} )\n"
    gh_tagging_blob+="- latest tag: [![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/${1}/${2}?include_prereleases&sort=semver)](https://github.com/${1}/${2}/releases)\n"
 
    markdown_blob+=$(echo -e "${gh_tagging_blob}")
}

function gh_meta(){

    # clearing variables
    website=''
    docs=''
    comms=''
    support=''
    special_notes=''
    # case statment for each projects meta information
    case ${2} in
        'Apfell')
            website='N/a'
            docs='https://docs.apfell.net/'
            comms='\*https://bloodhoundhq.slack.com/messages/apfell'
            support='N/a'
            special_notes="This project doesn't use github releases properly, so I can't auto enuermate information. Currently this project is on version 1.3 as of this post."
        ;;
        'Covenant')
            website='https://cobbr.io/Covenant.html'
            docs='https://github.com/cobbr/Covenant/wiki'
            comms='\*https://bloodhoundhq.slack.com/messages/covenant'
            support='N/a'
        ;;
        'sliver')
            website='N/a'
            docs='https://github.com/BishopFox/sliver/wiki/Getting-Started'
            comms='N/a'
            support='N/a'
        ;;
        'Faction')
            website='https://www.factionc2.com/'
            docs='https://www.factionc2.com/docs/'
            comms='\*https://bloodhoundhq.slack.com/messages/factionc2'
            support='N/a'
        ;;
        'SILENTTRINITY')
            website='N/a'
            docs='https://github.com/byt3bl33d3r/SILENTTRINITY/wiki'
            comms='\*https://bloodhoundhq.slack.com/messages/silenttrinity'
            support='[yes](https://github.com/byt3bl33d3r/SILENTTRINITY#sponsor-button-repo)'
        ;;
        'PoshC2_Python')
            website='N/a'
            docs='https://poshc2.readthedocs.io/en/latest/'
            comms='\*\*https://poshc2.slack.com'
            support='N/a'
        ;;
        'merlin')
            website='N/a'
            docs='https://github.com/Ne0nd0g/merlin/wiki'
            comms='N/a'
            support='N/a'
        ;;
        'C3')
            website='https://labs.mwrinfosecurity.com/tools/c3'
            docs='https://github.com/mwrlabs/C3/wiki'
            comms='N/a'
        ;;
    esac

    # edge case where the name of the C2 is the name of the org
    # so swapping C2 name and who by name
    if [[ "${2}" == "Faction" ]] ; then
        gh_meta_blob="\n### ${1}\n"
        gh_meta_blob+="( by [${2}](https://github.com/${1}) )\n"
    else
        gh_meta_blob="\n### ${2}\n"
        gh_meta_blob+="( by [${1}](https://github.com/${1}) )\n"
    fi
    gh_meta_blob+="#### Info ( ${2} )\n"
    gh_meta_blob+="- github: https://github.com/${1}/${2}\n"
    gh_meta_blob+="- website: ${website}\n"
    gh_meta_blob+="- docs: ${docs}\n"
    gh_meta_blob+="- comms: ${comms}\n"
    if ! [[ -z ${special_notes} ]] ; then
        gh_meta_blob+="- special note: ${special_notes}\n"
    fi
    gh_meta_blob+="#### Metadata ( ${2} )\n"
    gh_meta_blob+="- project contributors: [![GitHub contributors](https://img.shields.io/github/contributors/${1}/${2})](https://github.com/${1}/${2}/graphs/contributors)\n"
    gh_meta_blob+="- commits per week: [![GitHub commit activity](https://img.shields.io/github/commit-activity/w/${1}/${2})](https://github.com//${1}/${2}/graphs/commit-activity)\n"
    gh_meta_blob+="- stars: [![GitHub stars](https://img.shields.io/github/stars/${1}/${2})](https://github.com/${1}/${2}/stargazers)\n"
    gh_meta_blob+="- license: [![GitHub license](https://img.shields.io/github/license/${1}/${2})](https://github.com/${1}/${2}/blob/master/LICENSE)\n"

    markdown_blob+="$(echo -e "${gh_meta_blob}")"
}

function gh_proj_list(){
    counter=0
    for project in "${github_project_array[@]}" ; do
        printf "%d) %s\n" "${counter}" "${project}"
        (( counter+=1 ))
    done

}

function main(){
    printf "Do you want to generate all? [Y/n]\n"
    read -r gen_all
    case "${gen_all}" in
        'Y'|'y'|' ')
        gh_info
        ;;
        'N'|'n')
        gh_info
        gh_proj_list
        printf "Please choose which project you would like to generate. (Choose a number)\n"
        read -r chosen_project
        gh_info "${github_project_array[${chosen_project}]}"
        ;;
    esac
    counter=0
    for project in "${github_project_array[@]}" ; do
        user="${github_user_array[${counter}]}"
        gh_meta "${user}" "${project}"
        gh_issues "${user}" "${project}"
        gh_tagging "${user}" "${project}"
        # adding a jump to top section at the bottom of every section added
        markdown_blob+="$(echo -e "\n\nClick [here](#General-notes) to jump to the top")"
        (( counter+=1 ))
    done
    echo -e "${markdown_blob}"
}

main