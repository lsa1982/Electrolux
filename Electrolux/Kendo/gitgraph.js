(function () {
"use strict";
	function GitGraph(options) {
		// Options
		this.elementId =  "gitGraph";
		this.maxNivel = 0;
		// Canvas init
		this.canvas = document.getElementById(this.elementId) || options.canvas;
		this.canvas.style.border = "1px black solid ";
		this.canvas.style.position = "absolute" ;
		this.context = this.canvas.getContext("2d");

		// Navigation vars
		this.branchs = [];
		this.commits = [];

		this.canvas.addEventListener("click", { handleEvent: this.click , gitgraph: this, functionEvent: options.click }, false);
		var self = this;
		window.onresize = function (event) {
			self.render();
		};
	}

	GitGraph.prototype.click = function (event) {
		var self = this.gitgraph;
		var test = 0;
		
		// Fix firefox MouseEvent
		event.offsetX = event.offsetX ? event.offsetX : event.layerX;
		event.offsetY = event.offsetY ? event.offsetY : event.layerY;
		event.x = event.x ? event.x : event.clientX;
		event.y = event.y ? event.y : event.clientY;
		test = false;
		for (var i = 0, commit; !! (commit = this.gitgraph.commits[i]); i++) {
			if ((event.x >= self.canvas.offsetLeft + commit.x -window.scrollX ) &&(event.x <= self.canvas.offsetLeft + commit.x +64 -window.scrollX))
				if ((event.y >= self.canvas.offsetTop + commit.y -window.scrollY ) &&(event.y <= self.canvas.offsetTop + commit.y +64 -window.scrollY ))
					test = true;
			if (test) {
				break;
			}
		}
		this.functionEvent(commit);
	}

	GitGraph.prototype.branch = function (name, indexColumn) {
		// Options
		var options = {};
		options.name = name;
		options.parent = this;
		var branch = new Branch(options, indexColumn);
		this.branchs.push(branch);
		return branch;
	};

	GitGraph.prototype.newTemplate = function (options) {
		if (typeof options === "string") {
			return new Template().get(options);
		}
		return new Template(options);
	};

	GitGraph.prototype.render = function () {
		// Resize canvas
		this.canvas.height = this.maxNivel * 150;
 		this.canvas.width = 400;

		// Clear All
		this.context.clearRect(0, 0, this.canvas.width, this.canvas.height);
		for (var j = 0; j<this.commits.length; j++) 
			this.commits[j].isRender =false;
		// Add some margin
		this.context.translate(32, 32);

		// Render commits after to put them on the foreground

		var xOld = 0;
		var yOld = 0;
		for (var j = 0; j<this.commits.length; j++) {
			var x = (this.commits[j].nivelH -1) * 120  ;
			var y = 120 * this.commits[j].nivel;
			this.commits[j].render( x ,y);
			for (var h = 0; h<this.commits[j].padres.length; h++) {
				var cPadre = this.commits[j].padres[h];
				if (cPadre.isRender)
					this.commits[j].renderLine(cPadre.x, cPadre.y, x, y);
			}
			for (var h = 0; h<this.commits[j].hijos.length; h++) {
				var cHijo = this.commits[j].hijos[h];
				if (cHijo.isRender)
					this.commits[j].renderLine(x, y, cHijo.x, cHijo.y);
			}
		}
	};


	GitGraph.prototype.validaCommit  = function (vActividad){
		var i;
		for (i = 0; i < this.commits.length; ++i) {
			if (this.commits[i].idActividad == vActividad)
			{
				return this.commits[i];
				break;
			}
		}
	}

	GitGraph.prototype.creaNodo = function (options) {
		var master;
		if (this.branchs.length == 0) // Primer Nodo
		{
			var branchIndex = this.branchs.length +1;
			master = this.branch("master" + branchIndex, branchIndex );
			var commitParent = master.commit({
				actividad: options.actividad,
				idActividad: options.idActividad,
				idFinalizacion: "",
				finalizacion: "",
				firstCommit: true
			});
			var commitChildren = master.commit({
				actividad: options.actividad,
				idActividad: options.idActividadSiguiente,
				idFinalizacion: options.idFinalizacion,
				finalizacion: options.finalizacion,
				firstCommit: false,
				parentCommit: commitParent
			});
		}
		else{
			var commitSelect = this.validaCommit( options.idActividad);
			
			if (commitSelect == null)
			{
				var branchIndex = this.branchs.length +1;
				master = this.branch("master" + branchIndex, branchIndex);
				var commitChildren = master.commit({
					actividad: options.actividad,
					idActividad: options.idActividadSiguiente,
					idFinalizacion: options.idFinalizacion,
					finalizacion: options.finalizacion,
					firstCommit: false,
					parentCommit: commitSelect
				});
			}
			else{
				var commitChildren =  this.validaCommit( options.idActividadSiguiente);
				if (commitChildren == null){
					var newBranch = false;
					for (var i = 0; i < commitSelect.hijos.length ; i++ ){
						if (commitSelect.hijos[i].nivelH == commitSelect.nivelH){
							newBranch = true;
							break;
						}
					}
					if (newBranch)
					{
						var branchIndex = this.branchs.length +1;
						master = this.branch("master" + branchIndex, branchIndex);
					}
					else{
						master = commitSelect.branch;
					}
					var commitChildren = master.commit({
						actividad: options.actividad,
						idActividad: options.idActividadSiguiente,
						idFinalizacion: options.idFinalizacion,
						finalizacion: options.finalizacion,
						firstCommit: false,
						parentCommit: commitSelect
					});
				}
				else{
					commitSelect.hijos.push(commitChildren);
					commitChildren.padres.push(commitSelect);
				}
			}
		}
	}

	function Branch(options, indexColumn) {

		this.parent = options.parent;
		this.name = (typeof options.name === "string") ? options.name : "no-name";
		this.column = indexColumn;
		this.commits = [];
	}

	// ####################################
	// ### BRANCH COMMIT				###
	// ####################################

	Branch.prototype.commit = function (options) {
		// Options

		options.branch = this;
		options.parent = this.parent;
		options.parentCommit = options.parentCommit;

		var commit = new Commit(options);
		this.commits.push(commit);
		if (options.parentCommit instanceof Commit)
		{
			options.parentCommit.hijos.push(commit);
			commit.padres.push(options.parentCommit);
			commit.nivel = options.parentCommit.nivel +1;
			if (commit.nivel > options.parent.maxNivel)
				options.parent.maxNivel++;
			commit.nivelH = this.column ;
		}
		return commit;
	};

	// --------------------------------------------------------------------
	// -----------------------Commit ------------------------
	// --------------------------------------------------------------------

	function Commit(options) {
		options = (typeof options === "object") ? options : {};
		this.parent = options.parent;
		this.context = this.parent.context;
		this.branch = options.branch;
		this.idFinalizacion = options.idFinalizacion;
		this.idActividad = options.idActividad;
		this.idActividadSiguiente = options.idActividadSiguiente;
		this.finalizacion = options.finalizacion ;
		this.message =  options.actividad || " " || options.finalizacion || " - " || options.idActividad ;
		this.detail = options.detail || null;
		this.hijos = [];
		this.padres = [];
		this.isRender = false;
		this.parentCommit = options.parentCommit;
		this.x = 0;
		this.y = 0;
		this.nivel = 0;
		this.nivelH = 1;
		this.parent.commits.push(this);
	}

	// #####################
	// ### commit Render ###
	// #####################

	Commit.prototype.render = function (x,y) {
		// Dot

		this.context.beginPath();
		this.context.strokeStyle = "blue";
		this.context.fillStyle = "blue";
		this.context.arc(x, y, 16, 0, 2 * Math.PI, false);
		this.context.lineWidth = 16;
		this.context.stroke();
		this.context.fill();
		this.context.closePath();
		this.x = x;
		this.y = y;
		this.isRender = true;

	};

	Commit.prototype.renderLine = function (x0,y0, x1, y1) {
		// Dot
		var desplazoX = 0;
		var desplazoY = 0;
		var m = (y1-y0)/(x1-x0);
		var angulo = Math.atan(m);
		var signo = ">";

		this.context.beginPath();
		this.context.moveTo(x0, y0);
		this.context.lineWidth = 1;

		
		if ((y1 < y0)&&(x0==x1))
		{
			this.context.lineTo(x0 +60,y0);
			this.context.lineTo(x0 +60,y1);
			this.context.lineTo(x1,y1 );
			desplazoX = 60;
		}
		else{
			this.context.lineTo(x1 ,y1);
			if (y1 < y0){
				desplazoY = 10;
				desplazoX = -10;
			}
		}

		this.context.stroke();
		this.context.closePath();

		var message =this.finalizacion ;
		if (message.length > 10)
			message = message.substr(0,9) + "...";
		if (y1 > y0)
			message = message +">"; 
		else
			if( x0==x1 )
				message = message +">"; 
			else
				message ="<" + message;

		this.context.font = "normal 8pt Calibri";
		this.context.save();
		this.context.fillStyle = "black";
		this.context.textAlign="center"; 
		this.context.translate((x1+x0)/2 + desplazoX, (y1+y0)/2+desplazoY );
		this.context.rotate(angulo);
		this.context.fillText( message , 0, -3);
		this.context.restore();
	};

	window.GitGraph = GitGraph;
})();
