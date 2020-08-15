<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <p>
        <a class="btn btn-primary" data-toggle="collapse" href="#createIssue" role="button" aria-expanded="false" aria-controls="collapseExample">
            Add new issue
        </a>
    </p>
    <div class="collapse <#if issue??>show</#if>" id="createIssue">
        <form action="/issue/" method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Issue Name </label>
                <div class="col-sm-6">
                    <input type="text" name="name" class="form-control ${(nameError??)?string('is-invalid', '')}"
                           placeholder="Issue name" />
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
                <label class="col-sm-2 col-form-label">Reporter</label>
                <div class="col-sm-6">
                    <input type="text" name="reporter"
                           class="form-control ${(departmentError??)?string('is-invalid', '')}"
                           placeholder="${user.username}" readonly/>
                </div>
            </div>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Project</label>
                <div class="col-sm-6">
                    <input type="text" name="project"
                           class="form-control"
                           placeholder="${project.name}" readonly/>
                </div>
            </div>
            <p>
            <div>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#developers" aria-expanded="false" aria-controls="developers">Edit executor</button>
                <div class="collapse multi-collapse" id="developers">
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
            </p>
            <p>
            <div>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#statuses" aria-expanded="false" aria-controls="developers">Set status</button>
            <div class="collapse multi-collapse" id="statuses">
                <div class="card card-body">
                    <#list statuses as status>
                        <div>
                            <label>
                                <input name="status" type="radio" value="${status}" checked>
                                ${status}
                            </label>
                        </div>
                    </#list>
                </div>
            </div>
            </div>
            </p>
            <p>
            <div>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#type" aria-expanded="false" aria-controls="developers">Set type</button>
            <div class="collapse multi-collapse" id="type">
                <div class="card card-body">
                    <#list types as type>
                        <div>
                            <label>
                                <input name="type" type="radio" value="${type}" checked>
                                ${type}
                            </label>
                        </div>
                    </#list>
                </div>
            </div>
            </div>
            </p>
            <input type="hidden" name="_csrf" value="${_csrf.token}" />
            <button class="btn btn-primary" type="submit">Create</button>
        </form>
    </div>
</@c.page>