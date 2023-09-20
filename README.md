<h1 align='center'>Alv Repair Table</h1>

<p align='center'>This is a FiveM script that uses <a href='https://github.com/esx-framework/esx_core'>ESX</a>/<a href='https://github.com/qbcore-framework/qb-core'>QBCore</a>/<a href='https://github.com/overextended/ox_core'>OXCore</a> and <a href='https://github.com/overextended/ox_inventory'>OX Inventory</a> to allow players to fix guns by restoring their durability at a crafting bench in exchange for metal.</p>

<p align='center'>The script is heavily configurable and has features such as progress bars, animations & props, etc.</p>

<h1 align='center'> Installing this to your server.</h1>

<p align='center'>
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

<strong><p align='center'>If you are looking for a Developer with over 3 years of experience on FiveM, feel free to join my <a href='https://discord.gg/alv'>Discord Server</a> or visit my <a href='https://alv.gg'>Website</a>!</p></strong>
