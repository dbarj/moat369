// ----------------------------------------------------------------------------
// Written by Rodrigo Jorge <http://www.dbarj.com.br/>
// ----------------------------------------------------------------------------

function get_password() {
  var orig_pass = prompt("Please enter password","");
  if (orig_pass!=null && orig_pass!="") return orig_pass;
}

function get_param( name, url ) {
    if (!url) url = location.href;
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( url );
    return results == null ? null : results[1];
}

function decompText (compressedtext) {
  try {
    // Decode base64 (convert ascii to binary)
    var strData = atob(compressedtext);
    // Convert binary string to character-number array
    var charData = strData.split('').map(function(x){return x.charCodeAt(0);});
    // Turn number array into byte-array
    var binData = new Uint8Array(charData);
    // Gunzip
    var gunzip = new Zlib.Gunzip(binData);
    var data = gunzip.decompress();
    // Convert gunzipped byteArray back to ascii string:
    // Broken for long strings
    // return String.fromCharCode.apply(null, new Uint16Array(data));
    var strOut = new TextDecoder("utf-8").decode(data);
    return strOut;
  }
  catch(err) {
    return compressedtext;
  }
}

function rjorge_decrypt(secret, onload) {
  if (!secret) secret = get_password();
  var dectext = "";
  if (secret!=null && secret!="") dectext = CryptoJS.AES.decrypt(enctext, secret);
  if (dectext!=null && dectext!="") {
    try {
      var dectextutf = dectext.toString(CryptoJS.enc.Utf8);
    }
    catch(err) {
      if (!onload) alert ('Wrong Passphrase');
      return;
    }
    if (enctext_comp)
      var dectextuncomp = decompText(dectextutf);
    else
      var dectextuncomp = dectextutf;
    if (!onload && isIndexPage()) {
      setParamCurURL ('decKey',secret);
    }
    else {
      loadHTML(dectextuncomp);
      // Add decKey to all page links
      appendPassURL('decKey',secret);
    }
  }
}

function rjorge_decomp() {
  var dectextuncomp = decompText(enctext);
  loadHTML(dectextuncomp);
}

function loadHTML(htmltext) {
  document.getElementById("rjorge_block").innerHTML = htmltext;
  // When HTML is decoded, <script> sections are ignored. Need to manually reload them:
  reload_script_section("sqlfor_script");
  reload_script_section("sqlhl_script");
  loadJS("sorttable.js", function() {
    var newTableObject = document.getElementsByClassName("sortable")[0];
    if (newTableObject!=null && newTableObject!="") sorttable.makeSortable(newTableObject);
  });
  loadJS("http://www.gstatic.com/charts/loader.js", function() {
    reload_script_section("gchart_script");
  });
}

function reload_script_section(name) {
  var reload_script_sec_name = document.getElementById(name);
  if (reload_script_sec_name!=null && reload_script_sec_name!="") eval(reload_script_sec_name.text);
}

/*! loadJS: load a JS file asynchronously. [c]2014 @scottjehl, Filament Group, Inc. (Based on http://goo.gl/REQGQ by Paul Irish). Licensed MIT */
(function( w ){
	var loadJS = function( src, cb ){
		"use strict";
		var ref = w.document.getElementsByTagName( "script" )[ 0 ];
		var script = w.document.createElement( "script" );
		script.src = src;
		script.async = true;
		ref.parentNode.insertBefore( script, ref );
		if (cb && typeof(cb) === "function") {
			script.onload = cb;
		}
		return script;
	};
	// commonjs
	if( typeof module !== "undefined" ){
		module.exports = loadJS;
	}
	else {
		w.loadJS = loadJS;
	}
}( typeof global !== "undefined" ? global : this ));

function isIndexPage() {
  var url = window.location.pathname;
  if (url.match(/00001_.*_index.html$/)) return true;
  return false;
}

function appendPassURL(paramName, paramValue) {
  var myURL = document.getElementsByTagName('a');
  for(var i=0; i<myURL.length; i++){
    if (myURL[i].href.match(/.*html$/)) {
      myURL[i].href = myURL[i].getAttribute('href') + '?' + paramName + '=' + paramValue;
    }
  }
}

function setParamCurURL(paramName, paramValue) {
    var url = window.location.href;
    var hash = location.hash;
    url = url.replace(hash, '');
    if (url.indexOf(paramName + "=") >= 0)
    {
        var prefix = url.substring(0, url.indexOf(paramName));
        var suffix = url.substring(url.indexOf(paramName));
        suffix = suffix.substring(suffix.indexOf("=") + 1);
        suffix = (suffix.indexOf("&") >= 0) ? suffix.substring(suffix.indexOf("&")) : "";
        url = prefix + paramName + "=" + paramValue + suffix;
    }
    else
    {
    if (url.indexOf("?") < 0)
        url += "?" + paramName + "=" + paramValue;
    else
        url += "&" + paramName + "=" + paramValue;
    }
    window.location.href = url + hash;
}

window.onload = function() {
  if (enctext_encr) {
    var secret = get_param('decKey');
    if (secret!=null && secret!="") rjorge_decrypt(decodeURIComponent(secret), true);
  }
  else {
    if (enctext_comp) rjorge_decomp();
  }
}