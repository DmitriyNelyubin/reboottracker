<#import "parts/common.ftlh" as c>
<#import "parts/issue.ftlh" as i>

<@c.page>
    <h2>${username}</h2>
    ${message?ifExists}
    <form method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" placeholder="Password" minlength="4"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Email:</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" placeholder="example@sberbank.ru" value="${email!''}"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <p>
        <button class="btn btn-primary" type="submit">Save</button>
        </p>
    </form>
    <#if issues??>
    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#issues" aria-expanded="false" aria-controls="issues">Issues</button>
    </p>
    <div class="collapse" id="subIssues">
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
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <#list  issues as issue>
                <tr>
                    <td>${issue.id!}</td>
                    <td>${issue.name!}</td>
                    <td>${issue.description!}</td>
                    <td>${issue.reporter.username!}</td>
                    <td><#if issue.executor??>issue.executor.username<#else>no executor</#if></td>
                    <td>${issue.status!}</td>
                    <td>${issue.type!}</td>
                    <td><a href="/issueProfile/${issue.id}">more</a></td>
                </tr>
            </#list>
            </tbody>
        </table>
    </div>
    </div>
    </#if>
</@c.page>
