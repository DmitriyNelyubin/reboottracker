<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <p xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
        <h2>${issue.name}</h2>
    </p>
    <form action="/issue/" method="post">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Issue Name </label>
            <div class="col-sm-6">
                <input type="text" name="name" value="<#if issue??>${issue.name}</#if>"
                       class="form-control ${(nameError??)?string('is-invalid', '')}"
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
        <div>

            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#status" aria-expanded="false" aria-controls="status">Edit status</button>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#type" aria-expanded="false" aria-controls="type">Edit type</button>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#developers" aria-expanded="false" aria-controls="developers">Edit executor</button>
        </div>
        <p>
        <div class="row">
            <div class="col">
                <div class="collapse multi-collapse" id="status">
                    <div class="card card-body">
                        <p>Status: </p>
                        <#list statuses as status>
                            <div>
                                <label>
                                    <input name="status" type="radio" value="${status}" <#if status == issue.status>checked</#if>/>
                                    ${status}
                                </label>
                            </div>
                        </#list>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="collapse multi-collapse" id="type">
                    <div class="card card-body">
                        <p>Type: </p>
                        <#list types as type>
                            <div>
                                <label>
                                    <input name="type" type="radio" value="${type}"<#if issue.type == type>checked</#if>>
                                    ${type}
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
                                    <input name="executor" type="radio" value="${developer.id}" <#if project.developers??>${project.developers?seq_contains(developer)?string("checked", "")}</#if>>
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
    <p><b>Sub issues: </b>
    <#if issue.hasSubIssues>
        <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#subIssues" aria-expanded="false" aria-controls="subIssues">Sub issues</button>
        </p>
        <div class="collapse multi-collapse" id="subIssues">
            <#list  subIssues as subIssue>
                <div>
                    <p><a href="/issueEdit/${subIssue.id}">${subIssue.name}</a></p>
                </div>
            </#list>
        </div>
    <#else>
        no sub issues
    </#if>
</@c.page>