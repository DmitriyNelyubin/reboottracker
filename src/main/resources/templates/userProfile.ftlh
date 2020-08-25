<#import "parts/common.ftlh" as c>
<#import "parts/issue.ftlh" as i>

<@c.page>
    <h2>${username}</h2>
    ${message?ifExists}
    <form method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Password:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" placeholder="Password" minlength="4"/>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Email:</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" placeholder="example@sberbank.ru" value="${email!''}"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <p>
        <button class="btn btn-primary" type="submit">Save</button>
        </p>
    </form>
    <#if backlog?hasContent>
        </p>
        <table class="table">
            <@i.issueTHead false/>
            <@i.issueTBody false/>
        </table>
    <#else>
        no issues
    </#if>
</@c.page>
