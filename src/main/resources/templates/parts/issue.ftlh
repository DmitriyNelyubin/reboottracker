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
                                    <#if isSprint><td><input name="backlog" type="checkbox" value="${issue.id}" ></td></#if>
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

<#macro issueFilter path>
    <tbody>
    <form method="get" action="${path}" class="form-inline">
    <tr>
        <td>Filter</td>
        <td><input type="text" name="filterName" class="form-control"></td>
        <td><input type="text" name="filterDescription" class="form-control"></td>
        <td>
            <select name="filterReporter" class="form-control">
                <option selected></option>
                <#list users as user>
                    <option value="${user.id?ifExists}">${user.username}</option>
                </#list>
            </select>
        </td>
        <td><select name="filterExecutor" class="form-control">
                <option selected></option>
                <#list developers as developer>
                    <option value="${developer.id?ifExists}">${developer.username}</option>
                </#list>
            </select>
        <td>
            <input name="filterDate" class="form-control" type="date"/>
        </td>
        <td>
            <select name="filterStatus" class="form-control">
                <option selected></option>
                <#list statuses as status>
                    <option value="${status?ifExists}">${status}</option>
                </#list>
            </select>
        </td>
        <td>
            <select name="filterType" class="form-control">
                <option selected></option>
                    <#list types as type>
                        <option value="${type?ifExists}">${type}</option>
                    </#list>
            </select>
        </td>
        <td>
            <select name="filterSubIssues" class="form-control">
                <option selected></option>
                    <option value="true">true</option>
                    <option value="false">false</option>
            </select>
        </td>
        <th><button type="submit" class="btn btn-primary">Search</button></th>
    </tr>
    </form>
    </tbody>
</#macro>