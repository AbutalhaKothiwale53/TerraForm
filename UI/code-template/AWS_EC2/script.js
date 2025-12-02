function generateEc2Tfvars() {
    const awsAccountId = document.getElementById('awsAccountId').value;
    const awsRegion = document.getElementById('awsRegion').value;
    const instanceName = document.getElementById('instanceName').value;
    const instanceType = document.getElementById('instanceType').value;
    const amiId = document.getElementById('amiId').value;
    const subnetId = document.getElementById('subnetId').value;
    const rootVolumeSize = document.getElementById('rootVolumeSize').value;
    const rootVolumeType = document.getElementById('rootVolumeType').value;
    const project = document.getElementById('project').value;
    const environment = document.getElementById('environment').value;
    const department = document.getElementById('department').value;
    const associatePublicIp = document.getElementById('associatePublicIp').checked;
    
    const securityGroupIds = document.getElementById('securityGroupIds').value
        .split(',')
        .map(id => id.trim())
        .filter(id => id);

    if (!awsAccountId || !awsRegion || !instanceName || !instanceType || !amiId) {
        alert('Please fill in all required fields');
        return;
    }

    let tfvars = `aws_account_id  = "${awsAccountId}"\n`;
    tfvars += `aws_region      = "${awsRegion}"\n\n`;
    
    tfvars += `# Instance Configuration\n`;
    tfvars += `instance_name = "${instanceName}"\n`;
    tfvars += `instance_type = "${instanceType}"\n`;
    tfvars += `ami_id = "${amiId}"\n\n`;
    
    tfvars += `# Network Configuration\n`;
    tfvars += `subnet_id = "${subnetId}"\n`;
    tfvars += `security_group_ids = [${securityGroupIds.map(sg => `"${sg}"`).join(', ')}]\n`;
    tfvars += `associate_public_ip = ${associatePublicIp}\n\n`;
    
    tfvars += `# Storage Configuration\n`;
    tfvars += `root_volume_size = ${rootVolumeSize}\n`;
    tfvars += `root_volume_type = "${rootVolumeType}"\n\n`;
    
    tfvars += `# Tags\n`;
    tfvars += `project = "${project}"\n`;
    tfvars += `environment = "${environment}"\n`;
    tfvars += `department = "${department}"\n`;
    tfvars += `created_date = "${new Date().toISOString().split('T')[0]}"\n`;

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
