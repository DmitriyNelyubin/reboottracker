<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <h2 xmlns="http://www.w3.org/1999/html">Add sub issue</h2>
    <form action="/subIssue/" method="post">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <input type="hidden" name="superIssue" value="${issue.id}">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Issue Name </label>
            <div class="col-sm-6">
                <input type="text" name="name" value="<#if issue??>${issue.name}</#if>"
                       class="form-control ${(nameError??)?string('is-invalid', '')}"
                       placeholder="Sub issue name" />
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
                <input type="text" name="description" value="<#if issue??>${issue.description}</#if>"
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
                ${user.username}
                <input type="hidden" value="${user.id}" name="reporter">
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Project</label>
            <div class="col-sm-6">
                <div>
                    <input type="hidden" value="${project.id!}" name="project">
                    ${project.name}
                </div>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Super issue</label>
            <div class="col-sm-6">
                <div>
                    <input type="hidden" value="${issue.id!}" name="superIssue">
                    ${issue.name}
                </div>
            </div>
        </div>
        <p>
        <div>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#developers" aria-expanded="false" aria-controls="developers">Edit executor</button>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#statuses" aria-expanded="false" aria-controls="developers">Set status</button>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#type" aria-expanded="false" aria-controls="developers">Set type</button>
        </div>
            </p>
                <div class="row">
                    <div class="col">
        <div class="collapse multi-collapse" id="developers">
            <p>Developers:</p>
            <#list developers as developer>
                <div>
                    <label>
                        <input name="executor" type="radio"
                               value="${developer.id}" <#if project.developers??>${project.developers?seq_contains(developer)?string("checked", "")}</#if>>
                        ${developer.username}
                    </label>
                </div>
            </#list>
        </div>
        </div>
            <div class="col">
         <div class="collapse multi-collapse" id="statuses">
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
            <div class="col">
        <div class="collapse multi-collapse" id="type">
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
        <p><button class="btn btn-primary" type="submit">Create</button></p>
    </form>
</@c.page>