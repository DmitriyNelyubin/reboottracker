<#import "parts/common.ftlh" as c>
<#import "parts/project.ftlh" as p>

<@c.page>
    <div class="mb-1">Add new project</div>
    <@p.project "/createProject" true/>
</@c.page>