<#import "parts/common.ftlh" as c>

<@c.page>
    <h2>Project editor</h2>
    <form action="/projectList" method="post">
        <p>
        <div>
            <input type="hidden" value="${project.id}" name="projectId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <input type="text" name="name" value="${project.name}">
            <input type="text" name="description" value="${project.description}">
            <input type="text" name="department" value="${project.department}">
            <input type="radio" name="active" value="true" <#if project.isActive()>checked</#if>> isActive</input>
            <input type="radio" name="active" value="false" <#if !project.isActive()>checked</#if>> unActive</input>
        </div>
        <p>
        <div>

                    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#managers" aria-expanded="false" aria-controls="managers">Edit manager</button>
                    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#admins" aria-expanded="false" aria-controls="admins">Edit admin</button>
                    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#developers" aria-expanded="false" aria-controls="developers">Edit developers</button>
        </div>
        <div class="row">
        <div class="col">
            <div class="collapse multi-collapse" id="managers">
                <div class="card card-body">
                <p>Manager: <#if project.manager??>${project.manager.username}<#else>no manager</#if></p>
                <#list managers as manager>
                    <div>
                        <label>
                            <input name="manager" type="radio" value="${manager.id}" <#if manager??> <#if manager == project.manager>checked</#if></#if>>
                            ${manager.username}
                        </label>
                    </div>
                </#list>
                </div>
            </div>
        </div>
        <div class="col">
        <div class="collapse multi-collapse" id="admins">
            <div class="card card-body">
            <p>Admin: <#if project.admin??>${project.admin.username}<#else>no admin</#if></p>
            <#list admins as admin>
                <div>
                    <label>
                        <input name="admin" type="radio" value="${admin.id}"<#if project.admin??><#if project.admin == admin>checked</#if></#if>>
                        ${admin.username}
                    </label>
                </div>
            </#list>
                </div>
        </div>
        </div>
        <div class="col">
        <div class="collapse multi-collapse" id="developers">
            <div class="card card-body">
            <p>Developers:</p>
            <#list developers as developer>
                <div>
                    <label>
                        <input name="developer" type="checkbox" value="${developer.id}" <#if project.developers??>${project.developers?seq_contains(developer)?string("checked", "")}</#if>>
                        ${developer.username}
                    </label>
                </div>
            </#list>
            </div>
        </div>
        </div>
        </div>
        </p>
            <div>
             <button type="submit" class="btn btn-primary">Save</button>
            </div>
    </form>
</@c.page>