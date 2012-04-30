import StringIO
import simplejson as json
from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app

class Handler(webapp.RequestHandler):
    def write(self, resp):
        self.response.headers['Content-Type'] = 'application/json'
        self.response.out.write(json.dumps(resp))

    def handle(self):
        self.write(dict((arg, self.request.get(arg)) for arg in self.request.arguments()))
    
    def get(self):
        self.handle()

    def post(self):
        self.handle()

    def put(self):
        args = {}
        for arg in self.request.body.split('&'):
            arg = arg.split('=')
            args[arg[0]] = arg[1]
        
        self.write(args)

    def delete(self):
        self.handle()

application = webapp.WSGIApplication([
    ("/", Handler)
])

if __name__ == "__main__":
    run_wsgi_app(application)
    