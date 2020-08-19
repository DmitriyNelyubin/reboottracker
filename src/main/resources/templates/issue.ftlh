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
            <p>
            <div>
            <p><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#developers" aria-expanded="false" aria-controls="developers">Edit executor</button></p>
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
            </p>
            <p>
            <div>
            <p><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#statuses" aria-expanded="false" aria-controls="developers">Set status</button></p>
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
            <p><button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#type" aria-expanded="false" aria-controls="developers">Set type</button></p>
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
            <p><button class="btn btn-primary" type="submit">Create</button></p>
        </form>
    </div>
    <p><b>Issues: </b>
    <#if issues?has_content>
        </p>
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
                        <td><#if issue.executor??>${issue.executor.username}<#else>no executor</#if></td>
                        <td>${issue.status!}</td>
                        <td>${issue.type!}</td>
                        <td><#if issue.hasSubIssues><a href="/"><#else>no subissue</#if></td>
                        <#if isAdmin>
                            <td><a href="/issueProfile/${issue.id}">more</a></td>
                        </#if>
                    </tr>
                </#list>
                </tbody>
            </table>
    <#else>
        no issues
    </#if>
</@c.page>