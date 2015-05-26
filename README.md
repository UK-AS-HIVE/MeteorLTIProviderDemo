Basic demo of integrating a Meteor app into a Canvas assignment.

### Getting started
1.  Start the Canvas installation in a VM by invoking `vagrant up`.
2.  After the VM is ready, connect to it by typing `vagrant ssh`.
3.  On the VM, execute `cd canvas-lms && bundle exec rails server` to start up
    Canvas.
4.  Open a new terminal on your development machine and type `meteor
    --settings=settings.json` to fire up the LTI provider.
5.  Login to your Canvas instance at http://localhost:8080 (username:
    admin@canvas.dev, password: canvas)
6.  Create an assignment, and include an 'External Tool' using the URL
    http://localhost:3000 and the consumer and secret keys from settings.json
7.  Publish and visit the assignment.  You should be automatically logged into
    the inline Meteor with your Canvas credentials.

