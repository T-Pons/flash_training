(function () { "use strict";
var Main = function() {
	window.onload = $bind(this,this.init);
};
Main.main = function() {
	new Main();
};
Main.prototype = {
	init: function(e) {
		var canvas = window.document.createElement("canvas");
		window.document.body.appendChild(canvas);
		var ctx = canvas.getContext("2d");
		ctx.beginPath();
		ctx.fillRect(20,20,800,400);
	}
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
Main.main();
})();
