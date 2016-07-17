if [[ -d config/$PLATFORM ]]; then
  cd config/$PLATFORM
  vagrant destroy
  cd -
  rm -rf config/$PLATFORM
else
  echo "Vagrant config not found for $PLATFORM"
fi

