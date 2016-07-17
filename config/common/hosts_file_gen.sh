cat > config/$PLATFORM/hosts_file.yml <<- EOM
HOSTS:
  agent:
    roles:
      - master
    platform: ${PLATFORM_TYPE}
    hypervisor: none
    ip: 127.0.0.1
CONFIG:
  type: foss
  set_env: false
EOM
