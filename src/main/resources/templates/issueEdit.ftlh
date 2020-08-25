<#import "parts/common.ftlh" as c>
    <#import "parts/issue.ftlh" as i>
<#include "parts/security.ftlh">

<@c.page>
        <h2>${issue.name}</h2>
    <form action="/issueEdit/" method="post">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <input type="hidden" value="${issue.id}" name="issueId">
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
                <div class="collapse" id="status">
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
                <div class="collapse" id="type">
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
                <div class="collapse" id="developers">
                    <div class="card card-body">
                        <p>Developers:</p>
                        <#list developers as developer>
                            <div>
                                <label>
                                    <input name="executor" type="radio" value="${developer.id}" <#if issue.executor == developer>checked</#if>>
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
    <div>
    <#if subIssues?has_content>
        <p><b>Sub issues: </b>
            <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#subIssues" aria-expanded="false" aria-controls="subIssues">Sub issues</button>
        </p>
        <div class="collapse" id="subIssues">
            <table class="table">
                <@i.issueTHead false/>
                <tbody>
                <#list  subIssues as subIssue>
                    <tr>
                        <td>${subIssue.id!}</td>
                        <td>${subIssue.name!}</td>
                        <td>${subIssue.description!}</td>
                        <td>${subIssue.reporter.username!}</td>
                        <td><#if subIssue.executor??>issue.executor.username<#else>no executor</#if></td>
                        <td>${subIssue.creationDate}</td>
                        <td>${subIssue.status!}</td>
                        <td>${subIssue.type!}</td>
                        <td><a href="/issueProfile/${subIssue.id}">more</a></td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>
        </div>
    </#if>
    </div>
</@c.page>