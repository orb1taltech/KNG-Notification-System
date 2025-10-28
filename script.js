let notifications = [];

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'showNotification') {
        showNotification(data.data);
    }
});

function showNotification(data) {
    const container = document.getElementById('notification-container');

    // Create notification element
    const notification = document.createElement('div');
    notification.className = `notification ${data.type || 'info'}`;
    notification.id = `notification-${data.id}`;

    // Get icon based on type
    const icons = {
        success: 'Success',
        error: 'Error',
        warning: 'Warning',
        info: 'Info'
    };

    const icon = icons[data.type] || icons.info;

    notification.innerHTML = `
        <div class="notification-header">
            <div class="notification-icon">${icon}</div>
            <div class="notification-title">${data.title || 'Notification'}</div>
        </div>
        <div class="notification-message">${data.message || ''}</div>
        <div class="notification-progress"></div>
    `;

    // Add to container
    container.appendChild(notification);

    // Trigger show animation
    setTimeout(() => {
        notification.classList.add('show');
    }, 100);

    // Start progress bar animation
    const progressBar = notification.querySelector('.notification-progress');
    progressBar.style.width = '100%';
    progressBar.style.transition = `width ${data.duration || 5000}ms linear`;

    setTimeout(() => {
        progressBar.style.width = '0%';
    }, 100);

    // Auto hide after duration
    const timeoutId = setTimeout(() => {
        hideNotification(notification);
    }, data.duration || 5000);

    // Store notification
    notifications.push({
        id: data.id,
        element: notification,
        timeout: timeoutId
    });
}

function hideNotification(notification) {
    notification.classList.add('hide');

    setTimeout(() => {
        if (notification.parentNode) {
            notification.parentNode.removeChild(notification);
        }

        // Remove from notifications array
        notifications = notifications.filter(n => n.element !== notification);

        // Notify FiveM that notification was closed
        fetch(`https://${GetParentResourceName()}/notificationClosed`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        }).catch(() => {
            // Silently fail if fetch is blocked (common in FiveM)
        });
    }, 300);
}

// Handle ESC key to close all notifications
document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape') {
        notifications.forEach(n => {
            clearTimeout(n.timeout);
            hideNotification(n.element);
        });
        notifications = [];
    }
});