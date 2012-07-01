var autocompletes = new Object();
var key;

function setVisible(widget,visi){
	var x = document.getElementById(widget+"_shadow");
	var t = document.getElementsByName(widget)[0];
	x.style.position = 'absolute';
	x.style.top =  (findPosY(t)+3)+"px";
	x.style.left = (findPosX(t)+2)+"px";
	x.style.visibility = visi;
}

function init(widget, query){
	autocompletes[widget] = new Object();
	autocompletes[widget].outp = document.getElementById(widget+"_output");
        autocompletes[widget].oldins = "";
        autocompletes[widget].posi = -1;
        autocompletes[widget].words = new Array();
        autocompletes[widget].input = "";
        autocompletes[widget].query = query;
	window.setInterval("lookAt()", 200);
	setVisible(widget,"hidden");
	document.onkeydown = keygetter; //needed for Opera...
	document.onkeyup = keyHandler;
}

function findPosX(obj)
{
	var curleft = 0;
	if (obj.offsetParent){
		while (obj.offsetParent){
			curleft += obj.offsetLeft;
			obj = obj.offsetParent;
		}
	}
	else if (obj.x)
		curleft += obj.x;
	return curleft;
}

function findPosY(obj)
{
	var curtop = 0;
	if (obj.offsetParent){
		curtop += obj.offsetHeight;
		while (obj.offsetParent){
			curtop += obj.offsetTop;
			obj = obj.offsetParent;
		}
	}
	else if (obj.y){
		curtop += obj.y;
		curtop += obj.height;
	}
	return curtop;
}


function clearOutput(widget){
	var noten;
	var outp;

	outp = autocompletes[widget].outp;
	while (outp.hasChildNodes()){
		noten=outp.firstChild;
		outp.removeChild(noten);
	}
	posi = -1;
}



function lookAt(){
	var ins;
	var a;
        var widget;

	for (widget in autocompletes)
	{
		ins = document.getElementsByName(widget)[0].value;	
		a = autocompletes[widget];
		console.log("widget:",widget,"ins:",ins);
		if (a.oldins == ins) continue;
		else if (a.posi > -1);
		else if (ins.length > 0){
			a.words = getWord(widget,ins);
			if (a.words.length > 0){
				clearOutput(widget);
				for (var i=0;i < a.words.length; ++i) addWord (widget,a.words[i]);
				setVisible(widget,"visible");
				a.input = document.getElementsByName(widget)[0].value;
			}
			else{
				setVisible(widget,"hidden");
				a.posi = -1;
			}
		}
		else{
			setVisible(widget,"hidden");
			a.posi = -1;
		}
		a.oldins = ins;
	}
}
	
function addWord(widget,word){
	var sp = document.createElement("div");
	var a = autocompletes[widget];
	sp.appendChild(document.createTextNode(word));
	sp.onmouseover = function(){
		for (var i=0; i < a.words.length; ++i)
			setColor (widget, i, "white", "black");
		this.style.background = "blue";
		this.style.color= "white";
	}
	sp.onmouseout = mouseHandlerOut;
	sp.onclick = function(){
		document.getElementsByName(widget)[0].value = this.firstChild.nodeValue;
		setVisible(widget,"hidden");
		a.posi = -1;
		a.oldins = this.firstChild.nodeValue;
	}
	autocompletes[widget].outp.appendChild(sp);
}
	
	
function getWord(widget,beginning){
	var query = autocompletes[widget].query;
	var xhr;

	if (window.XMLHttpRequest)
  	{// code for IE7+, Firefox, Chrome, Opera, Safari
  		xhr=new XMLHttpRequest();
  	}
	else
  	{// code for IE6, IE5
  		xhr=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	xhr.open("GET",query+"?xhr=1&q="+beginning,false);
	xhr.send(null);
	if (xhr.responseText.length < 3) return [];
	return xhr.responseText.split("\n");	
}
	
function setColor (widget, _posi, _color, _forg){
	var outp = autocompletes[widget].outp;
	outp.childNodes[_posi].style.background = _color;
	outp.childNodes[_posi].style.color = _forg;
}
	
function keygetter(event){
	if (!event && window.event) event = window.event;
	if (event.keyCode) key = event.keyCode;
	else key = event.which;
        if (key == 13) {
        	if (event.stopPropagation) event.stopPropagation();
        	if (event.preventDefault) event.preventDefault();
        	return false;
	}	
}
		
function keyHandler(event){
	for (var widget in autocompletes) {
		if (document.getElementById(widget+"_shadow").style.visibility == "visible"){
		var a = autocompletes[widget];
		var textfield = document.getElementsByName(widget)[0];
		if (key == 40){ //Key down
			if (a.words.length > 0 && a.posi < a.words.length-1){
				if (a.posi >= 0) setColor(widget, a.posi, "#fff", "black");
				else a.input = textfield.value;
                                a.posi = a.posi+1;
				setColor(widget, a.posi, "blue", "white");
				textfield.value = a.outp.childNodes[a.posi].firstChild.nodeValue;
			}
		}
		else if (key == 38){ //Key up
			if (a.words.length > 0 && a.posi >= 0){
				if (a.posi >=1){
					setColor(widget, a.posi, "#fff", "black");
                                        a.posi = a.posi-1;
					setColor(widget, a.posi, "blue", "white");
					textfield.value = a.outp.childNodes[a.posi].firstChild.nodeValue;
				}
				else{
					setColor(widget,a.posi, "#fff", "black");
					textfield.value = a.input;
					textfield.focus();
					a.posi = a.posi-1;
				}
			}
		}
		else if (key == 27){ // Esc
			textfield.value = a.input;
			setVisible(widget,"hidden");
			a.posi = -1;
			a.oldins = a.input;
		}
		else if (key == 8){ // Backspace
			a.posi = -1;
			a.oldins=-1;
		}
                else if (key == 13){ // Return
			textfield.value = a.outp.childNodes[a.posi].firstChild.nodeValue;
			setVisible(widget,"hidden");
			a.oldins = a.outp.childNodes[a.posi].firstChild.nodeValue;
			a.posi = -1;
		}
		}
	}
}
	
var mouseHandlerOut=function(){
	this.style.background = "white";
	this.style.color= "black";
}
	

