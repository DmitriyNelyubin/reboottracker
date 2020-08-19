<#import "parts/common.ftlh" as c>

<@c.page>
    <a href="/projectEdit/${project.id}"><h2>${project.name}</h2></a>
        <div>
            <p><b>Project id: </b>${project.id}</p>
        </div>
        <div>
            <p><b>Project name: </b>${project.name}</p>
        </div>
        <div>
            <p><b>Project department: </b>${project.department}</p>
        </div>
        <div>
            <p><b>Project description: </b>${project.description}</p>
        </div>
        <div>
            <p><b>Project active: </b><#if project.isActive()>Active<#else>inActive</#if></p>
        </div>
        <div>
            <p><b>Manager: </b><#if project.manager??>${project.manager.username}<#else>no manager</#if></p>
        </div>
        <div>
            <p><b>Admin: </b><#if project.admin??>${project.admin.username}<#else>no admin</#if></p>
        </div>
        <p><b>Developers: </b>
            <#if developers?has_content>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#developers" aria-expanded="false" aria-controls="developers">Project developers</button>
        </p>
            <div class="collapse multi-collapse" id="developers">
                <#list  developers as developer>
                    <div>
                        <p>${developer.username}</p>
                    </div>
                </#list>
        </div>
        <#else>
            no developers
        </#if>
    <p><b>Issues: </b>
    <#if issues?has_content>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#issues" aria-expanded="false" aria-controls="issues">Project issues</button>
        </p>
        <div class="collapse multi-collapse" id="issues">
            <table class="table">
                <thead class="thead-light">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Description</th>
                    <th scope="col">Reporter</th>
                    <th scope="col">Executor</th>
                    <th scope="col">Status</th>
                    <th scope="col">Type</th>
                    <th scope="col">Sub issues</th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <#list issues! as issue>
                    <tr>
                        <td>${issue.id!}</td>
                        <td>${issue.name!}</td>
                        <td>${issue.description!}</td>
                        <td>${issue.reporter.username!}</td>
                        <td><#if issue.executor??>issue.executor.username<#else>no executor</#if></td>
                        <td>${issue.status!}</td>
                        <td>${issue.type!}</td>
                        <td><#if issue.hasSubIssues>Contain><#else>no subissue</#if></td>
                        <td><a href="/issueProfile/${issue.id}">more</a></td>
                    </tr>
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