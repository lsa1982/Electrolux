var appDir = '/Electrolux/';
function callScript(scriptName, args, execFunc) {
	var h = window.scrollY + (window.innerHeight / 2) - 160;
	var w = window.scrollX + (window.innerWidth / 2) - 225;
	$('#window').closest(".k-window").css({ top: h, left: w });
	$("#window").data("kendoWindow").open();
	
    var xhr_object = null;

    if (window.XMLHttpRequest)
        xhr_object = new XMLHttpRequest();
    else if (window.ActiveXObject)
        xhr_object = new ActiveXObject("Microsoft.XMLHTTP");
    else {
        alert("Su navegador no soporta los objetos XMLHTTPRequest...");
        return;
    }

    xhr_object.open("POST", scriptName, true);

    xhr_object.onreadystatechange = function () {
        if (xhr_object.readyState == 4) {

            $("#window").data("kendoWindow").close();
            var responseXhr = JSON.parse(xhr_object.responseText);
            if (responseXhr.errorCode != 0) {
                $("#mensaje").show(500);
                $("#mensaje").text(responseXhr.msgState);
            } else {
                if (responseXhr.pagina != "") {
                    window.location.href = responseXhr.pagina;
                }
                if (execFunc != null) {
                    execFunc(responseXhr.args);
                } 
                else {
                    $("#mensaje").show(500);
                    $("#mensaje").text("Operacion ejecutada");
                }
            }
        }
        return xhr_object.readyState;
    }
    xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr_object.send(args);
}

function serialize(form) {
	if (!form || form.nodeName !== "FORM") {
		return;
	}
	var i, q = [];
	for (i = form.elements.length - 1; i >= 0; i = i - 1) {
		if (form.elements[i].id === "") 
			continue;
		switch (form.elements[i].nodeName) {
			case 'INPUT':
				switch (form.elements[i].type) {
					case 'text':
					case 'hidden':
					case 'password':
					case 'button':
					case 'reset':
					case 'submit':
						q.push(form.elements[i].id + "=" + encodeURIComponent(form.elements[i].value));
						break;
					case 'checkbox':
					case 'radio':
						if (form.elements[i].checked) {
							q.push(form.elements[i].id + "=" + encodeURIComponent(form.elements[i].value));
						}
						break;
				}
				break;
			case 'file':
				break;
			case 'TEXTAREA':
				q.push(form.elements[i].id + "=" + encodeURIComponent(form.elements[i].value));
				break;
			case 'SELECT':
				switch (form.elements[i].type) {
					case 'select-one':
						q.push(form.elements[i].id + "=" + encodeURIComponent(form.elements[i].value));
						break;
					case 'select-multiple':
						for (j = form.elements[i].options.length - 1; j >= 0; j = j - 1) {
							if (form.elements[i].options[j].selected) {
								q.push(form.elements[i].id + "=" + encodeURIComponent(form.elements[i].options[j].value));
							}
						}
						break;
				}
				break;
		}
	}
	return q.join("&");
}


function enviaForm(jsValidator, jsForm, jsClase, jsOperacion, jsFunction) {
    if (jsValidator.validate()) {
        var pUrl = serialize(document.getElementById(jsForm));
        callScript(strInterOp( jsClase, jsOperacion), pUrl, jsFunction);
    }
};

function strInterOp(jsClase, jsOperacion) {
	
    return  appDir + "InterOpX.ashx?assem=" + assem + "&clase=" + jsClase + "&operacion=" + jsOperacion;
   };

function strInterOpAs(jsClase, jsOperacion,jsAssem) {
	return appDir + "InterOpX.ashx?assem=" + jsAssem + "&clase=" + jsClase + "&operacion=" + jsOperacion;
};

function getVarsUrl() {
    var url = location.search.replace("?", "");
    var arrUrl = url.split("&");
    var urlObj = {};
    for (var i = 0; i < arrUrl.length; i++) {
        var x = arrUrl[i].split("=");
        urlObj[x[0]] = x[1]
    }
    return urlObj;
};

function retornaCampos(item) {
    strGet = "";
    for (x in item) {
        if (typeof item[x] == "string") {
            if (x != 'uid' && x != 'id' && x != 'idField') {
                strGet = strGet + encodeURIComponent(x) + '=' + encodeURIComponent(item[x]) + '&';
            }
        }
    }
    return strGet;
};

var errorGrid = function (result) {
	$("#mensaje").show(500);
	$("#mensaje").text(result.errors);
	this.cancelChanges();
};
var cmdGrid = { command: [{ text: { edit: "Editar", cancel: "Cancelar", update: "Actualizar" }, name: "edit" }, { text: "Eliminar", name: "destroy"}], title: " ", width: "170px" };
var filtroGrid = {
	extra: true,
	messages: {
		and: "y",
		or: "o",
		filter: "Aplicar",
		clear: "Limpiar",
		info: "Filtrar por: "
	},
	operators: {
		string: {
			startswith: "Comienza por",
			eq: "Es igual a",
			neq: "No es igual a",
			contains: "Contiene"
		}
	}
};

var mensajeGrid =  {
      of: "de {0}",
      itemsPerPage: "registros por página",
      next: "Siguiente",
	  last: "Ultima",
	  previous: "Anterior",
	  display: "{0}-{1} de {2} registros"
    }

function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
	var expires = "expires=" + d.toGMTString();
	document.cookie = cname + "=" + cvalue + "; " + expires;
};

function getCookie(cname) {
	var name = cname + "=";
	var ca = document.cookie.split(';');
	for (var i = 0; i < ca.length; i++) {
		var c = ca[i];
		while (c.charAt(0) == ' ') c = c.substring(1);
		if (c.indexOf(name) != -1) return c.substring(name.length, c.length);
	}
	return "";
};

function checkCookie() {
	var user = getCookie("username");
	if (user != "") {
		alert("Welcome again " + user);
	} else {
		user = prompt("Please enter your name:", "");
		if (user != "" && user != null) {
			setCookie("username", user, 365);
		}
	}
};

function dsRead(jsClase, jsFuncion, jsAssem) {
	var xDs = {
		serverFiltering: true,
		type: "json",
		transport: {read: { url: strInterOpAs(jsClase, jsFuncion, jsAssem), dataType: "json", type: "post" }},
		schema: {errors: "msgState",data: "args",total: "totalFila"}
	}
	return xDs;
};

var dsEstado = [
	{ "idEstado": 0, "estado": "Todos" },
	{ "idEstado": 1, "estado": "Pendiente" },
	{ "idEstado": 2, "estado": "Finalizado" },
	{ "idEstado": 3, "estado": "Atrasado" },
	{ "idEstado": 4, "estado": "Anulado" }
];

function dehabilitarDiv(vDiv) {
	$('#' + vDiv).append('<div name="divBloqueo" style="position: absolute;top:0;left:0;width: 100%;height:100%;display: block;z-index: 10002;opacity: 0.5; background-color: #ccc;"></div>');
};

function habilitarDiv(vDiv) {
	$('#' + vDiv).find("div[name='divBloqueo']").remove();
};

function centrarWin(vDiv) {
	var h = window.scrollY + (window.innerHeight / 2) - 160;
	var w = window.scrollX + (window.innerWidth / 2) - 225;
	$(vDiv).closest(".k-window").css({ top: h, left: w });
}
