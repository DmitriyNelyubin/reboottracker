<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
    <div class="mb-1">
        <h2>
            Add new user
        </h2>
    </div>
    ${message!}
    <@l.login "/registration" true />
    <p>
    <div>After registration we will sanding validation link to confirm your email.</div>
    </p>
</@c.page>