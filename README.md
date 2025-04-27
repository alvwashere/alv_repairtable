<h1 align='center'>Alv Repair Table</h1>

<p align='center'>This is a FiveM script that uses <a href='https://github.com/esx-framework/esx_core'>ESX</a>/<a href='https://github.com/qbcore-framework/qb-core'>QBCore</a>/<a href='https://github.com/overextended/ox_core'>OXCore</a> and <a href='https://github.com/overextended/ox_inventory'>OX Inventory</a> to allow players to fix guns by restoring their durability at a crafting bench in exchange for metal.</p>

<p align='center'>The script is heavily configurable and has features such as progress bars, animations & props, etc.</p>

<p align='center'>Script Preview: <a href='https://www.youtube.com/watch?v=GInIUvLqdZM'>Alv.gg YouTube</a></p>

<h1 align='center'> Installing this to your server.</h1>

<p align='center'>
  <strong> Please ensure you install a release version as if it is not, you may get a version that is actively being worked on and may error.</strong><br><br>
  <strong>1.</strong> Download this repository and add the script to your resources folder.<br>
  <strong>2.</strong> Make sure the resource is started in the <code>server.cfg</code>, you can add <code>ensure alv_repairtable</code> if it isn't.<br>
  <strong>3.</strong> Make sure you add the item in the <code>config.lua</code> file to <code>ox_inventory</code>, if you need help with this see below...<br>
  <strong>4.</strong> Once you have completed those steps, the script is ready to be used simply restart your server and you are good to go!<br>
</p>

<h1 align='center'> Adding the item to OX Inventory.</h1>

<p align='center'>
  <strong>1.</strong> Navigate to your ox_inventory folder and open it, then open the data folder and finally open <code>items.lua</code>.<br>
  <strong>2. </strong>Within the items table, add the following code: <code>['scrapmetal'] = { label = 'Scrap Metal', weight = 80, },</code> <br>
  <strong>3.</strong> Save the file and restart your server, the item is now added to your server.<br>
</p>

<h1 align='center'> Have a suggestion?.</h1>

<p align='center'>
  Whether it be as simple as adding a new language to the locales or updating an actual feature within the script, we appreciate all feedback and try to accomodate to all server owners' needs. <br>
  Therefore, if you have a suggestion please join the Discord linked below at the bottom of this README file and leave your comment in the suggestions channel. 
</p>

<h1 align='center'> Experienced Developer? Try this!.</h1>

<p align='center'>
  <strong> If you want to have the best performance possible and you understand at least the basics of developing, you could also head to the <code>framework.lua</code> on both the client side and server side, remove all of the code there and add a shared script to the <code>fxmanifest.lua</code> with your frameworks import file, if it supports one. The frameworks this script can utilise will only auto-import via export/event.</strong><br><br>
</p>

<h1 align='center'> Need Support?</h1>

<p align='center'>
  I will offer support in my Community Discord, which can be found below as previously mentioned, if you need help with the script you can type in my general chat or makea ticket. Keep in mind that I am not available 24/7 so your response time may vary. You are welcome to ping me with your request to get a better chance of me seeing your message sooner!<br><br>
</p>

<strong><p align='center'>If you are looking for a Developer with over 5 years of experience on FiveM, feel free to join my <a href='https://discord.gg/QajHd7Snwy'>Discord Server</a>!</p></strong>
