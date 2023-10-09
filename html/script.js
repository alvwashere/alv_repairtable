window.addEventListener('message', function(event) {
  if (event.data.type === 'notification') {
    var notification = document.getElementById('notification');

    notification.style.display = 'block';
    notification.innerHTML = event.data.data.message;

    sleep(5000).then(() => {
      notification.style.display = 'none';
    });
  } else if (event.data.type === 'openui') {

  } else if (event.data.type === 'closeui') {

  }
}
