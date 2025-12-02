document.querySelectorAll('.nav-btn').forEach(btn => {
    btn.addEventListener('click', function() {
        const template = this.getAttribute('data-template');
        
        // Update active state
        document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
        
        // Load template
        const templatePath = template === 'backup' 
            ? 'code-template/AWS_BACKUP_TF/index.html'
            : 'code-template/AWS_EC2/index.html';
        
        document.getElementById('template-frame').src = templatePath;
    });
});
