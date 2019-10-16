const core = require('@actions/core');
const github = require('@actions/github');
const fs = require('fs');
const nunjucks = require('nunjucks');
const fm = require('front-matter');

async function handleNewIssue() {
    const token = core.getInput('repo-token');
    const octokit = new github.GitHub(token);
    const context = github.context;

    if (context.payload.issue == undefined) {
        throw Error(`This action should be run against issue events.
                    See https://help.github.com/en/articles/events-that-trigger-workflows#issues-event-issues`);
    }

    const issue = context.payload.issue;

    if (!(issue.title.startsWith("[NFS]") && hasNfsLabel(issue.labels))) {
        console.log("The issue is not a new NFS submission.");
        return;
    }

    let issueData = parseIssueBody(issue.body);
    issueData = {
        ...issueData,
        issue_url: `#${issue.number}`
    };

    let template = fs.readFileSync(".github/ISSUE_TEMPLATE/video-sub.md").toString();
    let { attributes, body } = fm(template);
    const env = nunjucks.configure({ autoescape: false });

    let templatedContent = {
        title: env.renderString(attributes.title, issueData),
        body: env.renderString(body, issueData)
    };

    title = issueData.framework_name;
    color = "000000".replace(/0/g, function () { return (~~(Math.random() * 16)).toString(16); });

    // Create a label with a valid description
    await octokit.issues.createLabel({
        owner: context.payload.repository.owner.login,
        repo: context.payload.repository.name,
        color: color,
        name: title,
        description: `specific to ${title} c2 framework`,
    });

    labels = ["video", "NFS", "enhancement", title];

    // Create the issue for the video
    await octokit.issues.create({
        owner: context.payload.repository.owner.login,
        repo: context.payload.repository.name,
        labels: labels,
        ...templatedContent,
    });

    await octokit.issues.addLabels({
        owner: context.payload.repository.owner.login,
        repo: context.payload.repository.name,
        issue_number: context.payload.issue.number,
        labels: ["NFS", "enhancement", "deps", title]
    })

}

function hasNfsLabel(labelArray) {
    return labelArray.filter(label => { return label.name == 'NFS' }).length > 0
}

function parseIssueBody(issueBody) {
    // get the name
    let nameStart = issueBody.indexOf("#### name");
    let name = issueBody.substring(nameStart + 9, issueBody.indexOf("<!--", nameStart)).trim();

    // get the additional context
    let additionalContextStart = issueBody.indexOf("#### Additional context");
    let additionalContext = issueBody.substring(additionalContextStart + 23).trim();
    return {
        framework_name: name,
        additional_context: additionalContext
    };
}

handleNewIssue()
    .then(
        () => {
            console.log("Success");
        },
        err => {
            console.log(`Errored: ${err.message}`);
            core.setFailed(`${err.message}`);
        }
    )
    .then(
        () => {
            process.exit();
        });
