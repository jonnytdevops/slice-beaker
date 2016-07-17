# slice-beaker

This tooling allows a user to execute beaker tests using the SLICE infrastructure.

## Usage
1. Make sure you are setup for API access to a SLICE region by following the SLICE User Docs.
Download the .pem file and place it inside your ~/.ssh/ directory.

2. Run the following vagrant commands to install the required plugin and dummy box

```
vagrant plugin install vagrant-openstack-provider
vagrant box add dummy https://github.com/cloudbau/vagrant-openstack-plugin/raw/master/dummy.box
```

3. Place your modules inside the ./modules folder.

4. Use the following example command to run the beaker tests:

```
MODULE=puppetlabs-ntp PLATFORM=centos-7-x86_64 PLATFORM_TYPE=el-7-x86_64 ./slice-beaker-run.sh
```

The created machine will still be around after the tests finish. You can re-use the machine by re-reunning the above command.
You may change the module tested if you wish.

5. To remove your VM from SLICE:

```
MODULE=puppetlabs-ntp PLATFORM=centos-7-x86_64 PLATFORM_TYPE=el-7-x86_64 ./slice-beaker-destroy.sh
```

Based on ody/slice-beaker
