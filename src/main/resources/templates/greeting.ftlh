<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">

<@c.page>
    <h5>Hello, comrade!</h5>
    <div>This is a my graduate project.</div>
    <div>This is minimalistic bugtracker.</div>
    <div>For use program please login.</div>
    <#if !user??><a href="login.ftlh">Sign in</a> </#if>
</@c.page>
