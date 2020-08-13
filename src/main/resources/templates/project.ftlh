<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page>
    <#if isAdmin>
        <p>
            <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
                Add new project
            </a>
        </p>
    <div class="collapse <#if project??>show</#if>" id="collapseExample">
        <form action="/project" method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Project Name </label>
                <div class="col-sm-6">
                    <input type="text" name="name" class="form-control ${(nameError??)?string('is-invalid', '')}"
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
                    <input type="text" name="description"
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
                    <input type="text" name="department"
                           class="form-control ${(departmentError??)?string('is-invalid', '')}"
                           placeholder="Department"/>
                    <#if departmentError??>
                        <div class="invalid-feedback">
                            ${departmentError}
                        </div>
                    </#if>
                </div>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button class="btn btn-primary" type="submit">Create</button>
        </form>
    </div>
    </#if>

    <p>
    <table class="table">
        <thead class="thead-light">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Department</th>
            <th scope="col">Manager</th>
            <#if isAdmin>
            <th scope="col"></th>
            </#if>
        </tr>
        </thead>
        <tbody>
        <#list projects! as project>
            <tr>
                <td>${project.id!}</td>
                <td>${project.name!}</td>
                <td>${project.department!}</td>
                <td>${project.manager.getUsername()!}</td>
                <#if isAdmin>
                <td><a href="/projectList/${project.id}">edit</a></td>
                </#if>
            </tr>
        </#list>
        </tbody>
    </table>
    </p>
</@c.page>