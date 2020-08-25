<#import "parts/common.ftlh" as c>
    <#import "parts/issue.ftlh" as i>
<#include "parts/security.ftlh">

<@c.page>
    <p><b>Backlog: </b>
        </p>
            <table class="table">
                <@i.issueTHead false/>
                <@i.issueFilter "/issue/${project.id}"/>

                <@i.issueTBody false/>
            </table>
    <#if !backlog?has_content>
        <p><h3>no issues</h3></p>
    </#if>
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
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#status" aria-expanded="false" aria-controls="status">Edit status</button>
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#type" aria-expanded="false" aria-controls="type">Edit type</button>
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#developers" aria-expanded="false" aria-controls="developers">Edit executor</button>
            </div>
            </p>

            <div class="row">
                <p>
                <div class="col">
                    <div class="collapse multi-collapse" id="status">
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
                <div class="col">
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
                <p>
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
    </p>
    </div>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    <p><button class="btn btn-primary" type="submit">Create</button></p>
    </form>
    </div>
    <div>
        <a href="/sprint/${project.id}">Add sprint</a>
    </div>
    <p><b>Sprints: </b>
    <#if sprints?has_content>
        <table class="table">
            <thead class="thead-light">
            <tr>
                <th scope="col">ID</th>
                <th scope="col">Name</th>
                <th scope="col">Description</th>
                <th scope="col">Project</th>
                <th scope="col">Start date</th>
                <th scope="col">Finish date</th>
                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
    <#list sprints! as sprint>
                <div>
                    <label>
                        <tr>
                            <td>${sprint.id!}</td>
                            <td>${sprint.name!}</td>
                            <td>${sprint.description!}</td>
                            <td>${sprint.project.name!}</td>
                            <td>${sprint.startDate!}</td>
                            <td>${sprint.finishDate!}</td>
                            <td><a href="/sprintProfile/${sprint.id}">more</a></td>
                        </tr>
                    </label>
                </div>
            </#list>
            </tbody>
        </table>
    <#else>
        no sprints
    </#if>
    </p>
</@c.page>