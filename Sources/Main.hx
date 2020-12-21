package;

import kha.Assets;
import kha.Color;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import js.node.Fs;
import js.node.console.Console;
import js.node.Http;

class Main {
	static var logo = ["1 1 1 1 111", "11  111 111", "1 1 1 1 1 1"];

	static function update(): Void {
		
	}

	static function render(frames: Array<Framebuffer>): Void {
		// As we are using only 1 window, grab the first framebuffer
		final fb = frames[0];
		// Now get the `g2` graphics object so we can draw
		final g2 = fb.g2;
		// Start drawing, and clear the framebuffer to `petrol`
		g2.begin(true, Color.fromBytes(0, 95, 106));
		// Offset all following drawing operations from the top-left a bit
		g2.pushTranslation(64, 64);
		// Fill the following rects with red
		g2.color = Color.Red;

		// Loop over the logo (Array<String>) and draw a rect for each "1"
		for (rowIndex in 0...logo.length) {
		  final row = logo[rowIndex];

		  for (colIndex in 0...row.length) {
		    switch row.charAt(colIndex) {
		      case "1": g2.fillRect(colIndex * 16, rowIndex * 16, 16, 16);
		      case _:
		    }
		  }
		}

		// Pop the pushed translation so it will not accumulate over multiple frames
		g2.popTransformation();
		// Finish the drawing operations
		g2.end();
	}

	public static function main() {
		Http.createServer(function(req, res) {
			res.writeHead(200, {'Content-Type': 'text/plain'});
			res.end('Hello World\n');
		}).listen(1337, '127.0.0.1');
		console.log('Server running at http://127.0.0.1:1337/');
		var output = Fs.createWriteStream('./stdout.log');
		var errorOutput = Fs.createWriteStream('./stderr.log');
		// custom simple logger
		var logger = new Console(output, errorOutput);
		// use it like console
		var count = 5;
		logger.log('count: %d', count);
		//Http.request("127.0.0.1", "", "", 3000, false, HttpMethod.Get, null, comman);
		
		System.start({title: "Project", width: 1024, height: 768}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (frames) { render(frames); });
			});
		});
	}
	//int int string -> void
	static function comman(one:Int, two:Int, STR:String):Void
	{
		if (STR == null)
		{
			throw "ERROR, FAILED TO CONNECT TO SERVER";
		}
		else
		{
			trace("Server status: " + two);
			trace(STR);
		}
	}
}
