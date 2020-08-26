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
    <#if backlog?has_content>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#issues" aria-expanded="false" aria-controls="issues">Issues</button>
        </p>
        <div class="collapse show" id="issues">
            <table class="table">
                <@i.issueTHead false/>
                <@i.issueFilter "/sprintProfile/${sprint.id}" false/>
                <@i.issueTBody false/>
            </table>
        </div>
    <#else>
        no issues
    </#if>
    </div>
    </div>
</@c.page>