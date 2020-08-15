<#macro issue path isCreateForm>
    <form action="${path}" method="post">
        <p>
        <div>
            <input type="hidden" value="${project.id}" name="projectId">
            <input type="hidden" value="${user.id}" name="reporterId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <input type="text" name="name" value="${issue.name!}">
            <input type="text" name="description" value="${issue.description!}">
            <input type="text" name="reporter" value="${issue.reporter!}">
        <p>
        <div>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#types" aria-expanded="false" aria-controls="types">Set type</button>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#statuses" aria-expanded="false" aria-controls="statuses">Set status</button>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#executors" aria-expanded="false" aria-controls="executors">Set executor</button>
        </div>
        <div class="collapse multi-collapse" id="types">
            <p>Type: <#if issue.type??>${issue.type}<#else>set type</#if></p>
            <#list types as type>
                <div>
                    <label>
                        <input name="type" type="radio" value="${type}" <#if type??> <#if type == issue.type>checked</#if></#if>>
                        ${issue.type}
                    </label>
                </div>
            </#list>
        </div>
        <div class="collapse multi-collapse" id="statuses">
            <p>Status: <#if issue.status??>${issue.status}<#else>set status</#if></p>
            <#list statuses as status>
                <div>
                    <label>
                        <input name="status" type="radio" value="${status}" <#if status??> <#if status == issue.status>checked</#if></#if>>
                        ${issue.status}
                    </label>
                </div>
            </#list>
        </div>
        <div class="collapse multi-collapse" id="executors">
            <p>Executor: <#if issue.executor??>${issue.executor.name}<#else>set executor</#if></p>
            <#list executors as executor>
                <div>
                    <label>
                        <input name="executor" type="radio" value="${executor}" <#if executor??> <#if executor == issue.executor>checked</#if></#if>>
                        ${issue.executor.name}
                    </label>
                </div>
            </#list>
        </div>
        </p>
        <div>
            <button type="submit" class="btn btn-primary"><#if isCreateForm>Create<#else>Save</#if></button>
        </div>
    </form>
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
                        <td><#if issue.hasSubissue><a href="/"><#else>no subissue</#if></td>
                        <#if isAdmin>
                            <td><a href="/issueList/${issue.id}">more</a></td>
                        </#if>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
    <#else>
        no issues
    </#if>
</#macro>