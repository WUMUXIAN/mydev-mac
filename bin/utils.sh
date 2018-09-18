#!/bin/bash

function rm_dangling_images() {
  images=$(docker images -q --filter "dangling=true")
  echo $images
  if [ "$images" != "" ]; then
	   docker rmi $images
  else
    echo "no dangling images to remove"
  fi
}

function show_process_life() {
  if [ $# != 1 ]; then
    echo "please specify the process"
  else
	   ps ax -o etime,command -c | grep $1
  fi
}

func remove_images_before_tag() {
  if [ $# != 1 ]; then
    echo "please specify the image name"
  else
    # split the tag with name
    IFS=: read -r name tag <<< "$1"
    echo "checking images before $1 for image $name"
    images=$(docker images $name --filter=before=$1 --format='{{.Repository}}:{{.Tag}}')
    echo $images
    if [ "$images" != "" ]; then
  	   docker rmi $images
    else
      echo "no older image to remove"
    fi
  fi
}

func find_dependent_images() {
  if [ $# != 1 ]; then
    echo "please specify the image id"
  else
    for i in $(docker images -q --filter=since=$1)
    do
      docker history $i | grep -q $1 && echo $i
    done | sort -u
  fi
    }
