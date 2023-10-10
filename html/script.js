const sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay))

window.addEventListener('message', function(event) {
  if (event.data.type === 'notification') {
    var notification = document.getElementById('notification');

    notification.style.display = 'block';
    notification.innerHTML = event.data.data.message;

    sleep(5000).then(() => {
      notification.style.display = 'none';
    });
  } else if (event.data.type === 'openui') {
    if (event.data.data.weapons) {
      var ui = document.getElementById('ui_main');
      ui.style.display = 'block';
      var ui_header = document.getElementById('ui_header');
      ui_header.innerHTML = event.data.data.title

      // Need to insert the elements as buttons into the table...
    }
  } else if (event.data.type === 'closeui') {
    var ui = document.getElementById('ui_main');
    ui.style.display = 'none';
  }
});
