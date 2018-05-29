#!/usr/bin/env python3
import http.server
import socketserver
import getpass
import crypt
from io import BytesIO
from string import Template

LISTEN_ADDR = '0.0.0.0'
LISTEN_PORT = 8000
KICKSTART_FILE = 'workstation.ks'

class KickstartHandler(http.server.SimpleHTTPRequestHandler):
  def send_head(self):
    if self.translate_path(self.path).endswith('/%s' % KICKSTART_FILE):
      self.send_response(200)
      self.send_header('Content-type', 'text/html; charset=ascii')
      self.send_header('Content-Length', str(len(body)))
      self.end_headers()
      return BytesIO(body.encode('ascii'))
    else:
      self.send_response(404)
      self.end_headers()

with open(KICKSTART_FILE, 'r') as f:
  t = Template(f.read())
  body = t.safe_substitute()

with socketserver.TCPServer((LISTEN_ADDR, LISTEN_PORT), KickstartHandler) as httpd:
  print('Serving kickstart file on http://%s:%d.' % (LISTEN_ADDR, LISTEN_PORT))
  try:
    httpd.serve_forever()
  except KeyboardInterrupt:
    print('Exiting.')
    exit(0)
