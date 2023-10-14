const sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay))

window.addEventListener('message', function(event) {
  if (event.data.type === 'notification') {
    var notification = document.getElementById('notification');

    notification.style.display = 'block';
    notification.innerHTML = event.data.data.message;

    sleep(event.data.time).then(() => {
      notification.style.display = 'none';
    });
  } else if (event.data.type === 'openui') {
    if (event.data.data.weapons) {
      var ui = document.getElementById('ui_main');
      ui.style.display = 'block';
      var ui_header = document.getElementById('ui_header');
      ui_header.innerHTML = event.data.data.title
      var ui = document.getElementById('ui_main');

      var ui_weapons = document.getElementById('ui_weapons')

      event.data.data.weapons.forEach(function(k) {
        var br = []
        var button = document.createElement('button');
        button.innerHTML = `${k.label} (${k.durability}%)`;
        button.value = k.slot
        button.onclick = function() {
          weaponPressed(k.slot);
        };
        ui_weapons.appendChild(button);
        for (let i = 0; i < 2; i++) {
          br[i] = document.createElement('br');
          ui_weapons.appendChild(br[i])
        }
      })
    }
  } else if (event.data.type === 'closeui') {
    deleteMenu()
  }
});

function deleteMenu() {
  var ui = document.getElementById('ui_main');
  ui.style.display = 'none';

  var ui_weapons = document.getElementById('ui_weapons');
  ui_weapons.remove()

  var new_ui = document.createElement('table')
  new_ui.id = 'ui_weapons'
  ui.appendChild(new_ui)

  $.post(`https://${GetParentResourceName()}/CloseMenu`)
}

function weaponPressed(value) {
  deleteMenu();

  $.post(`https://${GetParentResourceName()}/BeginRepair`, JSON.stringify({
    slot: value
  }));
}
