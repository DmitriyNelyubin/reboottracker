<#macro issueTHead isSprint>
                <thead class="thead-light">
                <tr>
                    <#if isSprint><th scope="col">To sprint</th></#if>
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
</#macro>

<#macro issueTBody isSprint>
    <tbody>
    <#list backlog! as issue>
                    <#if !issue.superIssue??>
                        <div>
                            <label>
                                <tr>
                                    <#if isSprint><td><input name="sprintIssues" type="checkbox" value="${issue.id}" ></td></#if>
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
</#macro>