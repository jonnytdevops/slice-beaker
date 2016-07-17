if [[ ! -d config/$PLATFORM ]]; then
  mkdir -p config/$PLATFORM
  cp config/Vagrantfile ./config/$PLATFORM/
  sed -i '' "s/MODULE_NAME/${MODULE}/g" config/$PLATFORM/Vagrantfile
  sed -i '' "s/PLATFORM_NAME/${PLATFORM}/g" config/$PLATFORM/Vagrantfile
  ./config/common/hosts_file_gen.sh
  cd ./config/$PLATFORM
  vagrant up --provider=openstack --debug
  cd -
else
  rm -rf ./config/$PLATFORM/Vagrantfile
  cp config/Vagrantfile ./config/$PLATFORM/
  sed -i '' "s/MODULE_NAME/${MODULE}/g" config/$PLATFORM/Vagrantfile
  sed -i '' "s/PLATFORM_NAME/${PLATFORM}/g" config/$PLATFORM/Vagrantfile
  cd ./config/$PLATFORM
  vagrant provision --debug
  cd -
fi

