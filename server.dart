import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_static/shelf_static.dart';
import 'package:shelf_router/shelf_router.dart';

void main() async {
  var staticPath = 'build/web';
  var staticHandler = createStaticHandler(staticPath,
      defaultDocument: 'index.html', serveFilesOutsidePath: true);
  var mainHandler = createStaticHandler(staticPath,
      defaultDocument: 'main.dart.js', serveFilesOutsidePath: true);
  var assetsHandler = createFileHandler('assets');
  var app = Router();
  app.get('/', staticHandler);
  app.get('/main.dart.js', mainHandler);
  app.get('/assets/', assetsHandler);
  var server = await io.serve(app, 'localhost', 7777);
  print('Serving at http://${server.address.host}:${server.port}');
}
