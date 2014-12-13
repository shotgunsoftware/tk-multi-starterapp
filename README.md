# Welcome to the Shotgun Pipeline Toolkit Starter App!

This app serves as a quick way to get started when doing Toolkit App development.
If you want to get up and running quickly, follow these simple steps:

## Step 1. Pick a branch!

This repo has got several branches, illustrating slightly different workflows:

- the `master` branch contains a standard multi app which runs in all engines.
- the `shotgun_multi_select` branch shows how to get started if you want to create
  a *shotgun specific* app where you can select multiple objects in Shotgun and 
  pass this selection into the app.

## Step 2. Fork this Repository!

First of all, fork this repo. You can fork it to your own github accout or fork it to
an internal git server, that's totally up to you! At this time, make sure you also 
rename it to something sensible. We recommend the naming convention `tk-ENGINE-APPNAME`, 
where ENGINE is set to `multi` if the app can run in more than one engine. For example, 
if you are working on a rigging tool in maya, you may want to name it `tk-maya-characterposer`.

## Step 3. Install your forked App in Toolkit

### Create a Dev Area
Now, first things first - before starting development, let's install the App. First, create a 
development sandbox for your project by going to the pipeline configurations page in Shotgun
and click select "Clone" on the menu when right clicking on the primary pipeline configuration.
This will give you a private place to do development and you wont be disturbing the production.

### Install the new repository
With your development sandbox there will be a specific tank command that you can use to address
this particular configuration. Open a shell and navigate to your sandbox. Now run the install app
command. When you install an app, you need to choose an environment and an engine. The engine is
the application you will be running, so either `tk-maya`, `tk-nuke` etc. The environment is a
collection of tools that you want to run against a specific work area. In our default 
configuration, when working with Shots, the environment is called `shot_step` and 
when working with Assets, the environment is called `asset_step`. 

```
> cd /your/development/sandbox
> ./tank install_app shot_step tk-maya user@remotehost:/path_to/tk-multi-mynewapp.git
```

This will find the latest git tag and install that into your setup. If you want more information 
about how the install_app command works, just run it without any options.

Now, to test that the App was installed correctly, go to a Shot task in Shotgun and launch maya
from your development sandbox. Toolkit now tracks this repository and if you create new tags, 
these will be detected by Toolkit's update system. 

## Step 4. Set up your local environment

Now clone your forked repo locally, so that you have the code on disk somewhere. Next, we need
to switch toolkit so that it doesn't track the latest tag in the git repo, but instead looks
at your local code. For example, if you have your locally checked out code in `/Users/john.smith/dev/tk-multi-mynewapp`, 
you would do the following:

```
> cd /your/development/sandbox
> ./tank switch_app shot_step tk-maya tk-multi-mynewapp /Users/john.smith/dev/tk-multi-mynewapp
```
 
## Step 5. Make changes!

Make changes to your code. Since you are now running tookit with a dev setup, there is a reload 
option on the menu. Clicking this will reload all apps and configuration, making it easy and 
quick to iterate.

## Step 6. Tag up a version and switch back to git mode

When you are ready to release, tag up a version in git. Name it for example `v1.0.0`.
Then, switch back to git mode. Toolkit will pick up the tag with the higest number
and use that - your dev area is no longer used by the system.

```
> cd /your/development/sandbox
> ./tank switch_app shot_step tk-maya tk-multi-mynewapp user@remotehost:/path_to/tk-multi-mynewapp.git
```

## Step 7. Push your config changes to the production config

Lastly, push your configuration changes to the Primary production config for the project.

```
> cd /your/development/sandbox
> ./tank push_configuration 
```
