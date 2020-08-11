<#import "parts/common.ftlh" as c>

<@c.page>
    List of projects
    <table>
        <thead>
        <tr>
            <th>Project</th>
            <th>Description</th>
            <th>Department</th>
        </tr>
        </thead>
        <tbody>
        <#list projects as project>
            <tr>
                <td>${project.name}</td>
                <td>${project.description}</td>
                <td>${project.department}</td>
            </tr>
        </#list>
        </tbody>
    </table>
</@c.page>