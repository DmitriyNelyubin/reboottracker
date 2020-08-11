<#import "parts/common.ftlh" as c>

<@c.page>
    Project editor

    <form action="/project" method="post">
        <input type="hidden" value="${project.id}" name="userId">
        <input type="hidden" value="${_csrf.token}" name="_csrf">
        <input type="text" name="name" value="${project.name}">
        <input type="text" name="description" value="${project.description}">
        <input type="text" name="department" value="${project.department}">
        <input type="radio" name="active" value="true" checked>isActive</input>
        <input type="radio" name="active" value="false">unActive</input>
        <#list managers as manager>
            <div>
                <label><input type="checkbox" name="${manager}" ${manager.getUsername()!}>${manager}</label>
            </div>
        </#list>

        <button type="submit">Save</button>
    </form>
</@c.page>