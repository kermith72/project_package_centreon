# project_package_centreon
Project to create Debian packages for Centreon

 ## Use Docker to build Centreon debs
 Build a debian image with all dependencies
 ```
 docker build -t centreonbuild_debian .
 ```
 Lanch packages building
 ```
 docker run -v <path_to_project_package_centreon>:/data centreonbuild_debian
 ```

 ## Use build.sh script (check the Dockerfile)
 ``
 ./build.sh
