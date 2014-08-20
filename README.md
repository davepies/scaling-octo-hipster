### Getting started

Install [Node](http://nodejs.org). If you're using a Mac, the simplest way is with [Homebrew](http://brew.sh)

```bash
$ brew install node
```

Next, install of of the required Node packages:

```bash
$ npm install
```

You'll need [Bower](http://bower.io) installed as well (the -g flag makes bower available globally, including at the CLI):

```bash
$ npm install -g bower
```

Finally, grab the front-end assets:

```bash
$ bower install
```

Now you can run the project with

```bash
$ gulp
```

By default this will run on port 3000.
