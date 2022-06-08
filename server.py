from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory='build/web', **kwargs)

httpd = HTTPServer(('localhost', 4443), Handler)

context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain('certificate.crt', 'private.key')

httpd.socket = context.wrap_socket (httpd.socket, 
         server_side=True)

httpd.serve_forever()