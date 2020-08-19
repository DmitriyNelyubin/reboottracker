<#import "parts/common.ftlh" as c>

<@c.page>
    <h2>Project editor</h2>
    <form action="/projectEdit" method="post">
        <p>
        <div>
            <input type="hidden" value="${project.id!}" name="projectId">
            <input type="hidden" value="${_csrf.token}" name="_csrf">
            <div class="form-group row">
            <label class="col-sm-2 col-form-label">Project Name </label>
            <div class="col-sm-6">
                <input type="text" name="name" value="<#if project??>${project.name!}</#if>"
                       class="form-control ${(nameError??)?string('is-invalid', '')}"
                       placeholder="Project name" />
                <#if nameError??>
                    <div class="invalid-feedback">
                        ${nameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Description</label>
            <div class="col-sm-6">
                <input type="text" name="description" value="<#if project??>${project.description}</#if>"
                       class="form-control ${(descriptionError??)?string('is-invalid', '')}"
                       placeholder="Description"/>
                <#if descriptionError??>
                    <div class="invalid-feedback">
                        ${descriptionError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Department</label>
            <div class="col-sm-6">
                <input type="text" name="department" value="<#if project??>${project.department}</#if>"
                       class="form-control ${(descriptionError??)?string('is-invalid', '')}"
                       placeholder="Department"/>
                <#if departmentError??>
                    <div class="invalid-feedback">
                        ${departmentError}
                    </div>
                </#if>
            </div>
        </div>

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