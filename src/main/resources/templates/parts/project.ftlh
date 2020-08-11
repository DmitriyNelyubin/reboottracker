<#macro project path isCreateForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Project Name :</label>
            <div class="col-sm-6">
                <input type="text" name="name" class="form-control ${(nameError??)?string('is-invalid', '')}"
                       placeholder="Project name" />
                <#if nameError??>
                    <div class="invalid-feedback">
                        ${nameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Description</label>
            <div class="col-sm-6">
                <input type="text" name="description"
                       class="form-control ${(descriptionError??)?string('is-invalid', '')}"
                       placeholder="Description"/>
                <#if descriptionError??>
                    <div class="invalid-feedback">
                        ${descriptionError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label">Department</label>
            <div class="col-sm-6">
                <input type="text" name="department"
                       class="form-control ${(departmentError??)?string('is-invalid', '')}"
                       placeholder="Department"/>
                <#if departmentError??>
                    <div class="invalid-feedback">
                        ${departmentError}
                    </div>
                </#if>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary" type="submit">Create</button>
    </form>
</#macro>