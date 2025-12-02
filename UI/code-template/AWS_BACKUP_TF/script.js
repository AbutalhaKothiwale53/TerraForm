function generateTfvars() {
    const awsAccountId = document.getElementById('awsAccountId').value;
    const awsRegion = document.getElementById('awsRegion').value;
    const projectName = document.getElementById('projectName').value;
    const department = document.getElementById('department').value;
    const environment = document.getElementById('environment').value;
    const backupPlanName = document.getElementById('backupPlanName').value;
    const recoveryPointDays = document.getElementById('recoveryPointDays').value;
    const scheduleExpression = document.getElementById('scheduleExpression').value;
    const scheduleMode = document.getElementById('scheduleMode').value;
    
    const resourceTypes = Array.from(document.querySelectorAll('input[name="resource_types"]:checked'))
        .map(cb => cb.value);
    const resourceIds = document.getElementById('resourceIds').value
        .split(',')
        .map(id => id.trim())
        .filter(id => id);

    if (!awsAccountId || !awsRegion || !projectName || !environment) {
        alert('Please fill in all required fields');
        return;
    }

    let tfvars = `aws_account_id  = "${awsAccountId}"\n`;
    tfvars += `aws_region      = "${awsRegion}"\n\n`;
    tfvars += `# Project Information\n`;
    tfvars += `project     = "${projectName}"\n`;
    tfvars += `department  = "${department}"\n`;
    tfvars += `environment = "${environment}"\n`;
    tfvars += `created_date = "${new Date().toISOString().split('T')[0]}"\n\n`;
    
    tfvars += `# Backup Configuration\n`;
    tfvars += `backup_plan_name = "${backupPlanName}"\n`;
    tfvars += `recovery_point_retention_days = ${recoveryPointDays}\n`;
    tfvars += `schedule_mode = "${scheduleMode}"\n`;
    tfvars += `schedule_expression = "${scheduleExpression}"\n\n`;
    
    tfvars += `# Resources\n`;
    tfvars += `resource_types = [${resourceTypes.map(r => `"${r}"`).join(', ')}]\n`;
    tfvars += `resource_ids = [${resourceIds.map(r => `"${r}"`).join(', ')}]\n`;

    document.getElementById('tfvarsOutput').textContent = tfvars;
    document.getElementById('outputSection').style.display = 'block';
    window.tfvarsContent = tfvars;
}

function copyToClipboard() {
    if (!window.tfvarsContent) {
        alert('Please generate terraform.tfvars first');
        return;
    }
    navigator.clipboard.writeText(window.tfvarsContent).then(() => {
        alert('Copied to clipboard!');
    });
}

function downloadTfvars() {
    if (!window.tfvarsContent) {
        alert('Please generate terraform.tfvars first');
        return;
    }
    const element = document.createElement('a');
    element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(window.tfvarsContent));
    element.setAttribute('download', 'terraform.tfvars');
    element.style.display = 'none';
    document.body.appendChild(element);
    element.click();
    document.body.removeChild(element);
}
