<#include "parts/security.ftlh">
<#import "parts/common.ftlh" as c>

<@c.page>
    <h2>Project list</h2>
    <p>
    <table class="table">
        <thead class="thead-light">
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Name</th>
            <th scope="col">Department</th>
            <th scope="col">Manager</th>
            <#if isAdmin>
                <th scope="col"></th>
            </#if>
        </tr>
        </thead>
        <tbody>
        <#list projects! as project>
            <tr>
                <td>${project.id!}</td>
                <td>${project.name!}</td>
                <td>${project.department!}</td>
                <td>${project.manager.getUsername()!}</td>
                <#if isAdmin>
                    <td><a href="/projectList/${project.id}">edit</a></td>
                </#if>
            </tr>
        </#list>
        </tbody>
    </table>
    </p>
</@c.page>