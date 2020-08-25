<#import "parts/common.ftlh" as c>
    <#import "parts/issue.ftlh" as i>

<@c.page>
    <a href="/issueEdit/${issue.id}"><h2>${issue.name}</h2></a>
    <div>
        <p><b>Issue id: </b>${issue.id}</p>
    </div>
    <div>
        <p><b>Issue project name: </b><a href="/projectList/${issue.project.id}"> ${issue.project.name}</a></p>
    </div>
    <#if issue.superIssue??>
        <div>
            <p><b>Super issue name: </b> <a href="/issueProfile/${issue.superIssue.id}"> ${issue.superIssue.name}</a> </p>
        </div>
    </#if>
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
    <#if !issue.superIssue??>
        <div>
            <a href="/subIssue/${issue.id}">Add sub issue</a>
        </div>
        <div>
        <#if issue.hasSubIssues>
            <p><b>Sub issues: </b>
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#subIssues" aria-expanded="false" aria-controls="subIssues">Sub issues</button>
            </p>
                <div class="collapse" id="subIssues">
                                <table class="table">
                                    <@i.issueTHead false/>
                                    <tbody>
                                    <#list  subIssues as subIssue>
                                            <tr>
                                                <td>${subIssue.id!}</td>
                                                <td>${subIssue.name!}</td>
                                                <td>${subIssue.description!}</td>
                                                <td>${subIssue.reporter.username!}</td>
                                                <td><#if subIssue.executor??>${subIssue.executor.username}<#else>no executor</#if></td>
                                                <td>${subIssue.status!}</td>
                                                <td>${subIssue.type!}</td>
                                                <td><a href="/issueProfile/${subIssue.id}">more</a></td>
                                            </tr>
                                    </#list>
                                    </tbody>
                                </table>
                            </div>
                </div>
            </#if>
        </div>
    </#if>
</@c.page>