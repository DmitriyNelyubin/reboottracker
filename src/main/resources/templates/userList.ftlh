<#import "parts/common.ftlh" as c>

<@c.page>
    <h2>List of users</h2>

    <table class="table">
        <thead class="thead-light">
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
        </tr>
        </thead>
        <tbody>
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role}<#sep>, </#list></td>
                <td><a href="/user/userProfile/${user.id}">more</a></td>
            </tr>
        </#list>
        </tbody>
    </table>
</@c.page>