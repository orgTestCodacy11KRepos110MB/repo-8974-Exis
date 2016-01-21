#!/usr/bin/python

helpstr = '''Riffle maintenance and management.

Usage:
  stump init
  stump list
  stump push (all | REPOS...)
  stump pull (all | REPOS...)
  stump add-subtree DIRECTORY NAME URL
  stump test (all | LANGUAGES...)           
  stump deploy (all | REPOS...)         

Options:
  -h --help     Show this screen.
'''

import os
import sys
import docopt
from subprocess import call
import shutil

# Format: (prefix: remote, url)
SUBTREES = [
    ("ios/swiftRiffle", "swiftRiffle", "git@github.com:exis-io/swiftRiffle.git"),
    ("ios/appBackendSeed", "iosAppBackendSeed", "git@github.com:exis-io/iosAppBackendSeed.git"),
    ("ios/appSeed", "iosAppSeed", "git@github.com:exis-io/iosAppSeed.git"),
    ("ios/example", "iosExample", "git@github.com:exis-io/iOSExample.git"),

    ("js/jsRiffle", "jsRiffle", "git@github.com:exis-io/jsRiffle.git"),
    ("js/ngRiffle", "ngRiffle", "git@github.com:exis-io/ngRiffle.git"),
    ("js/angularSeed", "ngSeed", "git@github.com:exis-io/ngSeed.git"),

    ("core", "core", "git@github.com:exis-io/core.git"),

    ("python/pyRiffle", "pyRiffle", "git@github.com:exis-io/pyRiffle.git"),

    ("CardsAgainstHumanityDemo/swiftCardsAgainst", "iosCAH", "git@github.com:exis-io/CardsAgainst.git"),
    ("CardsAgainstHumanityDemo/ngCardsAgainst", "ngCAH", "git@github.com:exis-io/ionicCardsAgainstEXIStence.git")
]


if __name__ == '__main__':
    args = docopt.docopt(helpstr, options_first=True, help=True)
    allLanguages = ['swift', 'js', 'python']

    if args['init']:
        print "Adding remotes"

        for p, r, u in SUBTREES:
            call("git remote add %s %s" % (r, u,), shell=True)

        print "Linking go libraries"
        gopath = os.getenv('GOPATH', None)

        if gopath is None:
            print 'You dont have a $GOPATH set. Is go installed correctly?'
        else:
            corePath = os.path.join(gopath, 'src/github.com/exis-io/core')

            # Remove existing symlinks
            if os.path.islink(corePath):
                os.unlink(corePath)

            # Delete the library if there's anything there
            if os.path.exists(corePath):
                shutil.rmtree(corePath)

            os.symlink(os.path.abspath("core"), corePath)

    elif args['list']:
        for p, r, u in SUBTREES:
            print "Remote: ", r

    elif args['push']:
        if args['all']:
            repos = SUBTREES
        else:
            repos = [x for x in SUBTREES if x[1] in args['REPOS']]

        b = 'master'

        print "Pushing: ", repos

        for p, r, u in repos:
            call("git subtree push --prefix %s %s %s" % (p, r, b,), shell=True)

    elif args['pull']:
        repos = SUBTREES if args['all'] else args['REPOS']
        b = 'master'

        for p, r, u in repos:
            call("git subtree pull --prefix %s %s %s -m 'Update to stump' --squash" % (p, r, b,), shell=True)

    elif args['add-subtree']:
        call("git remote add %s %s" % (args['NAME'], args['URL'],), shell=True)
        call("git subtree add --prefix %s %s master" % (args['DIRECTORY'], args['NAME'],), shell=True)

        print 'Subtree added. Please edit the SUBTREES field in this script: \n("%s", "%s", "%s")' % (args['DIRECTORY'], args['NAME'], args['URL'])

    elif args['test']:
        os.environ["EXIS_REPO"] = os.getcwd()
        # TODO: unit tests
        # TODO: integrate a little more tightly with unit and end to end tests
         
        langs = allLanguages if args['all'] else sys.argv[2:]

        call("python arbiter/arbiter.py -f testAll %s" % " ".join(["-a {}".format(x) for x in langs]), shell=True)

    elif args['deploy']:
        print "Not implemented"


'''
Start xcode with open source swift version: 
    xcrun launch-with-toolchain /Library/Developer/Toolchains/swift-latest.xctoolchain

Use open source swift on command line: 
    export PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/bin:"${PATH}"

Deployment scripts from old stump

ios() {
    echo "Updating riffle, seeds, and cards to version $1"

    git subtree push --prefix swift/swiftRiffle swiftRiffle master

    git clone git@github.com:exis-io/swiftRiffle.git
    cd swiftRiffle
    
    git tag $1 
    git push --tags

    pod trunk push --allow-warnings --verbose

    cd ..
    rm -rf swiftRiffle

    # update the seed projects and push them 
    cd swift/appSeed
    pod update

    cd ../appBackendSeed
    pod update
    cd ../..

    git add --all
    git commit -m "swRiffle upgrade to v $1"

    git subtree push --prefix swift/appBackendSeed iosAppBackendSeed master
    git subtree push --prefix swift/appSeed iosAppSeed master
    git push origin master
}

js() {
    echo "Updating js to version $1"

    browserify js/jsRiffle/index.js --standalone jsRiffle -o jsRiffle.js
    browserify js/jsRiffle/index.js --standalone jsRiffle | uglifyjs > jsRiffle.min.js

    mv jsRiffle.js js/jsRiffle/release/jsRiffle.js
    mv jsRiffle.min.js js/jsRiffle/release/jsRiffle.min.js

    cd js/jsRiffle
    npm version $1
    npm publish

    cd ../ngRiffle
    npm version $1
    npm publish

    cd ../..

    git add --all
    git commit -m "jsRiffle upgrade to v $1"

    git push origin master
    git subtree push --prefix js/jsRiffle jsRiffle master
    git subtree push --prefix js/ngRiffle ngRiffle master

    git clone git@github.com:exis-io/jsRiffle.git
    cd jsRiffle
    git tag $1 
    git push --tags
    cd ..
    rm -rf jsRiffle

    git clone git@github.com:exis-io/ngRiffle.git 
    cd ngRiffle
    git tag $1 
    git push --tags
    cd ..
    rm -rf ngRiffle

    # Do something with the seed app!
}
'''
