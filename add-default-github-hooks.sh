#!/bin/sh

# Use this script to add the IRC and Jenkins webhooks to the GitHub repositories.
# You will need to add credentials to your $HOME/.netrc for this to work.

die () {
	echo "$*" >&2
	exit 1
}

test $# = 1 ||
die "Usage: $0 <org>/<repository>"

repository="$1"

mycurl () {
	curl --netrc "$@" "$url"
}

url="https://api.github.com/repos/$repository/hooks"
hooks="$(mycurl)"

# IRC
if ! echo "$hooks" | grep '^    "name": "irc",$'
then
	echo "Adding IRC hook"
	mycurl -XPOST -d '{"name":"irc","active":true,"events":["push","pull_request"],"config":{"server":"irc.freenode.net","port":"6667","room":"#imagejdev","message_without_join":"1","notice":"1"}}'
fi

# Jenkins
if ! echo "$hooks" | grep '^    "name": "jenkinsgit",$'
then
	echo "Adding Jenkins hook"
	mycurl -XPOST -d '{"name":"jenkinsgit","active":true,"events":["push"],"config":{"jenkins_url":"http://jenkins.imagej.net/"}}'
fi
