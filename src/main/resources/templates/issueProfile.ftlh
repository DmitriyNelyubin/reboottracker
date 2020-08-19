<#import "parts/common.ftlh" as c>

<@c.page>
    <a href="/issueEdit/${issue.id}"><h2>${issue.name}</h2></a>
    <div>
        <p><b>Issue id: </b>${issue.id}</p>
    </div>
    <div>
        <p><b>Issue project name: </b>${issue.project.name}</p>
    </div>
    <div>
        <p><b>Issue name: </b>${issue.name}</p>
    </div>
    <div>
        <p><b>Issue description: </b>${issue.description}</p>
    </div>
    <div>
        <p><b>Issue reporter: </b>${issue.reporter.username}</p>
    </div>
    <div>
        <p><b>Issue executor: </b>${issue.executor.username}</p>
    </div>
    <div>
        <p><b>Issue status: </b>${issue.status}</p>
    </div>
    <div>
        <p><b>Issue type: </b>${issue.type}</p>
    </div>
    <div>
        <p><b>Creation date: </b>${issue.creationDate}</p>
    </div>
    <div>
        <p><b>Close date: </b><#if issue.closeDate??>${issue.closeDate}<#else> not closed </#if></p>
    </div>
    <#if issue.superIssue??>
    <div>
        <p><b>Super issue: </b><a href="/issueEdit/${issue.superIssue.id}">${issue.superIssue.name}</a></p>
    </div>
    </#if>
    <div>
    <p><b>Sub issues: </b>
    <#if issue.hasSubIssues>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#subIssues" aria-expanded="false" aria-controls="subIssues">Sub issues</button>
        </p>
        <div class="collapse multi-collapse" id="subIssues">
            <#list  subIssues as subIssue>
                <div>
                    <p><a href="/issueEdit/${subIssue.id}">${subIssue.name}</a></p>
                </div>
            </#list>
        </div>
    <#else>
        no sub issues
    </#if>
    </div>
    <p><a href="/issueEdit/${issue.id}">Add sub issue</a></p>
</@c.page>