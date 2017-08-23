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

function rjorge_decode(secret, onload) {
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
    if (!onload && isIndexPage()) {
      setParamCurURL ('decKey',secret);
    }
    else {
      document.getElementById("rjorge_block").innerHTML = dectextutf;
      reload_script_section("gchart_script");
      reload_script_section("sqlfor_script");
      reload_script_section("sqlhl_script");
      var newTableObject = document.getElementsByClassName("sortable")[0];
      if (newTableObject!=null && newTableObject!="") sorttable.makeSortable(newTableObject);
      appendPassURL('decKey',secret);
    }
  }
}

function reload_script_section(name)
{
  var reload_script_sec_name = document.getElementById(name);
  if (reload_script_sec_name!=null && reload_script_sec_name!="") eval(reload_script_sec_name.text);
}

function load_js(name)
{
  var head= document.getElementsByTagName('head')[0];
  var script= document.createElement('script');
  script.type= 'text/javascript';
  script.src= name;
  head.appendChild(script);
}

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

function setParamCurURL(paramName, paramValue)
{
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

window.onload = function(){
  var secret = get_param('decKey');
  if (secret!=null && secret!="") rjorge_decode(decodeURIComponent(secret), true);
}