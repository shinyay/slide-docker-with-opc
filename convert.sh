#!/bin/bash
pandoc -s -t revealjs --template=revealjs.template -V theme:mozilla-devrel-light -V  transition:page --slide-level=2 slide.md -o slide.html
