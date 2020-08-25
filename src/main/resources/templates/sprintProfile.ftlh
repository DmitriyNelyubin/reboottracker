<#import "parts/common.ftlh" as c>
    <#import "parts/issue.ftlh" as i>

<@c.page>
    <a href="/sprintEdit/${sprint.id}"><h2>${sprint.name}</h2></a>
    <div>
        <p><b>Sprint id: </b>${sprint.id}</p>
    </div>
    <div>
        <p><b>Sprint name: </b>${sprint.name}</p>
    </div>
    <div>
        <p><b>Sprint description: </b>${sprint.description}</p>
    </div>
    <div>
        <p><b>Project : </b>${sprint.project.name}</p>
    </div>
    <div>
        <p><b>Start date: </b>${sprint.startDate}</p>
    </div>
    <div>
        <p><b>Finish date: </b>${sprint.finishDate}</p>
    </div>
    <#if issues?has_content>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#issues" aria-expanded="false" aria-controls="issues">Issues</button>
        </p>
        <div class="collapse multi-collapse" id="issues">
            <table class="table">
                <@i.issueTHead false/>
                <tbody>
                <#list issues! as issue>
                    <#if !issue.superIssue??>
                        <tr>
                            <td>${issue.id!}</td>
                            <td>${issue.name!}</td>
                            <td>${issue.description!}</td>
                            <td>${issue.reporter.username!}</td>
                            <td><#if issue.executor??>${issue.executor.username}<#else>no executor</#if></td>
                            <td>${issue.status!}</td>
                            <td>${issue.type!}</td>
                            <td><#if issue.hasSubIssues>Contain<#else>no subissue</#if></td>
                            <td><a href="/issueProfile/${issue.id}">more</a></td>
                        </tr>
                    </#if>
                </#list>
                </tbody>
            </table>
        </div>
    <#else>
        no issues
    </#if>
    </div>
    </div>
</@c.page>