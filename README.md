# Apache Httpd Image Builder

JBC Labs generic image builder for Apache Httpd. This is the default build configuration for Apache Httpd images and is used by the JBC Labs Component Builder service

Default build workflow:

1. Component builder starts with a task to create a apache image and then dynamically retrieves this repository.
2. Component builder updates the FROM image based on the component configuration to pull the proper version of the apache image.
3. Component builder retrieves and prepares the specified code artifact.
4. Component builder executes a Docker Build to generate an image
    - Pulls the proper official apache image as the base image layer
    - Copies the build.sh and entrypoint.sh into the image
    - Copies the conf/ directory which includes server.xml file into image.
    - Copies the code artifact into the image
    - Executes the build.sh script to prepare the image to run.
5. Component builder pushes the generated image to a designated container repository

# How to customize apache component setup
1. If you only need customize the apache configuration files, the build.sh script will automatically look for a directory in the code artifact called apache-conf, in which case it will overwrite the default configuration files

2. Clone this repository to modify and then update the build artifact in your application component configuration within JBC Labs to use your own customized builder.
    - Simplest option is to modify the build.sh and entrypoint.sh scripts to prepare and customize the image. 
      - build.sh runs once during the docker build process. It can be used to install software packages into image.
      - entrypoint.sh runs every time that image starts and can be utilized to prepare run time environment like exporting environment variables, setting the PATH etc.
  
    - Alternatively you can also modify the Dockerfile and use Docker syntax to build your own customized image. If you create your own Dockerfile you will also need to update the image artifact in JBC Labs as component builder will override the FROM line in the Dockerfile with the image specified in the config.
