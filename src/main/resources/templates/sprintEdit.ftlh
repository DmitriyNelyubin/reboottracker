<#import "parts/common.ftlh" as c>
<#import "parts/issue.ftlh" as i>
<#include "parts/security.ftlh">

<@c.page>

        <p>
            <b>Sprint editor</b>
        </p>
            <div>
            <form action="/sprintEdit/" method="post">
                <div class="form-group row">
                    <label class="col-sm-2 col-form-label">Sprint Name </label>
                    <div class="col-sm-6">
                        <input type="hidden" name="sprint" value="${sprint.id}">
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
                               value="${startDate}" id="creation-date-input"/>
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
                               value="${finishDate}" id="close-date-input"/>
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
                            <@i.issueTBody true/>
                        </table>
                    <#else>
                       <b>Project backlog empty</b>
                    </#if>
        </div>
                <p>
                <div>
                    <button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#sprint" aria-expanded="false" aria-controls="sprint">Sprint issues</button>
                </div>
                </p>
                <div class="collapse multi-collapse" id="sprint">
                    <#if sprintIssues?has_content>
                        <table class="table">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col">To backlog</th>
                                <th scope="col">ID</th>
                                <th scope="col">Name</th>
                                <th scope="col">Description</th>
                                <th scope="col">Reporter</th>
                                <th scope="col">Executor</th>
                                <th scope="col">Date</th>
                                <th scope="col">Status</th>
                                <th scope="col">Type</th>
                                <th scope="col">Sub issues</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <#list sprintIssues! as issue>
                                <#if !issue.superIssue??>
                                    <div>
                                        <label>
                                            <tr>
                                                <td><input name="sprintIssues" type="checkbox" value="${issue.id}" ></td>
                                                <td>${issue.id!}</td>
                                                <td>${issue.name!}</td>
                                                <td>${issue.description!}</td>
                                                <td>${issue.reporter.username!}</td>
                                                <td><#if issue.executor??>${issue.executor.username}<#else>no executor</#if></td>
                                                <td>${issue.creationDate!}</td>
                                                <td>${issue.status!}</td>
                                                <td>${issue.type!}</td>
                                                <td><#if issue.hasSubIssues>Contain<#else>no subissue</#if></td>
                                                <td><a href="/issueProfile/${issue.id}">more</a></td>
                                            </tr>
                                        </label>
                                    </div>
                                </#if>
                            </#list>
                            </tbody>
                        </table>
                    <#else>
                        Sprint hasn't issues
                    </#if>
                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                </div>
                <div>
                  <p><button class="btn btn-primary" type="submit">Save</button></p>
                </div>
            </form>
        </div>
</@c.page>