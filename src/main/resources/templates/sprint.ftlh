<#import "parts/common.ftlh" as c>
    <#import "parts/issue.ftlh" as i>
<#include "parts/security.ftlh">

<@c.page>
    <#if backlog?has_content>
    <p>
        <a class="btn btn-primary" data-toggle="collapse" href="#createSprint" role="button" aria-expanded="false" aria-controls="createSprint">
            Add new sprint
        </a>
    </p>
    <div class="collapse <#if sprint??>show</#if>" id="createSprint">
        <form action="/sprint/" method="post">
            <div class="form-group row">
                <label class="col-sm-2 col-form-label">Sprint Name </label>
                <div class="col-sm-6">
                    <input type="text" name="name" value="<#if sprint??>${sprint.name}</#if>"
                           class="form-control ${(nameError??)?string('is-invalid', '')}"
                           placeholder="Sprint name" />
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
                    <input type="text" name="description" value="<#if sprint??>${sprint.description}</#if>"
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
                <label class="col-sm-2 col-form-label">Project</label>
                <div class="col-sm-6">
                    <div>
                        <input type="hidden" name="project" value="${project.id}">
                        ${project.name}
                    </div>
                </div>
            </div>
            <div class="form-group row">
                <label for="creation-date-input" class="col-sm-2 col-form-label">Start date</label>
                <div class="col-sm-6">
                    <input class="form-control ${(startDateError??)?string('is-invalid', '')}" type="date" name="startDate"
                           value="<#if sprint??>${startDate}<#else>${currentDate}</#if>" id="creation-date-input"/>
                    <#if startDateError??>
                        <div class="invalid-feedback">
                            ${startDateError}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label for="close-date-input" class="col-sm-2 col-form-label">Finish date</label>
                <div class="col-sm-6">
                    <input class="form-control ${(finishDateError??)?string('is-invalid', '')}" type="date" name="finishDate"
                           value="<#if sprint??>${finishDate}<#else>${currentDate}</#if>" id="close-date-input"/>
                    <#if finishDateError??>
                        <div class="invalid-feedback">
                            ${finishDateError}
                        </div>
                    </#if>
                </div>
            </div>
            <p>
            <div>
                <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#backlog" aria-expanded="false" aria-controls="backlog">Project backlog</button>
            </div>
            </p>
            <div class="collapse multi-collapse" id="backlog">
            <#if backlog?has_content>
                <table class="table">
                    <@i.issueTHead true/>
                    <tbody>
                    <#list backlog! as issue>
                        <#if !issue.superIssue??>
                    <div>
                        <label>

                            <tr>
                                <td><input name="sprintIssues" type="checkbox" value="${issue.id}" checked></td>
                                <td>${issue.id!}</td>
                                <td>${issue.name!}</td>
                                <td>${issue.description!}</td>
                                <td>${issue.reporter.username!}</td>
                                <td><#if issue.executor??>${issue.executor.username}<#else>no executor</#if></td>
                                <td>${issue.status!}</td>
                                <td>${issue.type!}</td>
                                <td><#if issue.hasSubIssues><a href="/"><#else>no subissue</#if></td>
                                    <td><a href="/issueProfile/${issue.id}">more</a></td>
                            </tr>
                        </label>
                    </div>
                        </#if>
                    </#list>
                    </tbody>
                </table>
            <#else>
                no issues
            </#if>
    <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </div>
    <p><button class="btn btn-primary" type="submit">Create</button></p>
    </form>
    </div>
    <#else>
    <h3><b>Project backlog empty</b></h3>
    </#if>
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

</@c.page>