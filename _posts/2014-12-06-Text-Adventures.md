---
title: Text Adventures
layout: oneColumnPost 
type: post
style: "http://mcormier.github.io/nodeAdventure/demo/cathode/client.css"
customStyle: |
  .post p { color: rgb(174, 110, 62); }
  .site .footer { color: rgb(174, 110, 62); 
                  border-top: 4px solid #fb8949;
                  background:white;
                  margin-top:200px;
   }
  .site { margin-bottom:0px; }
  #narrative { position: relative; margin-top:20px; margin-bottom:90px; }

---


I recently came across a text adventure game by [www.darksecretsoftware.com][darksecret] which I found inspirational.  Sandy Walsh posted the source for the game on [GitHub][dsgit]. After taking a gander at the source I was inspired to port it from Python Django to [node.js][nodeAdv]. 

<script src="https://cdn.socket.io/socket.io-1.2.0.js"></script>
<script src="http://mcormier.github.io/js/PPUtils-1.0.1.js"></script>
<script src="http://mcormier.github.io/nodeAdventure/demo/common.js"></script>

<script>
var command_string = "";
var socket;
function init() {
socket = getWebSocket(false);
socket.on('stories', function(storyList) { socket.emit('chooseStory', 'CATSS'); } );
socket.on('display', displayHandler );
socket.on('errorMsg', errorMsgHandler );
socket.on('displayMessage', displayMsgHandler );
PPUtils.bind('keydown', document, keyDownHandler, false)
PPUtils.bind('keypress', document, captureKeyInput, true)
document.onkeypress=captureKeyInput;
window.setInterval( toggleCursorVisibility, 600);
}

PPUtils.bind("load", window, init);
</script>

<div id="narrative">
<div id="workarea">

<div class="startScreen">
</div>
<div class="console">
<div id="cmd">
<div id="prompt"> &gt; </div>
<span id="cmd_input"></span>
<div id="cursor"></div>
</div>
 
</div>

</div>
</div>

Sorry, no mobile support.  If you want to play the game you'll have to get yourself to a device with a physical keyboard. I'm also binding to the document object for keyboard events, which may not be the most wise thing to do.  It's been tested with some versions of Chrome, Safari and Firefox.  Your mileage may vary.

[darksecret]:http://www.darksecretsoftware.com
[dsgit]:https://github.com/SandyWalsh/DarkSecretSoftware
[nodeAdv]:https://github.com/mcormier/nodeAdventure
