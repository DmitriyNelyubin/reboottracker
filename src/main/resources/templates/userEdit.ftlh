<#import "parts/common.ftlh" as c>

<@c.page>
    <h2>User editor</h2>
    <form action="/user" method="post">
        <p>
        <div>
        Edit name
        <input type="text" name="username" value="${user.username}">
        </div>
        </p>
        <div>
            <th>
                Edit role :
            </th>
        <#list roles as role>
            <td>
                    <label><input type="checkbox" class="from-chek-input" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
            </td>
        </#list>
        </div>
        <input type="hidden" value="${user.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <button type="submit" class="btn btn-primary">Save</button>
    </form>
</@c.page>