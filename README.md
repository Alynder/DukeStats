# DukeStats

To run this package 

docker build -t duke .

Once the docker is finished building run the following:

docker run --rm -it -v $(pwd):/output duke


Once the docker is up and running the entry point is set to just run the script and if there's an issue an error message will give the issue with the ssh.
The volume that gets attached during the docker run command is an output directory with statistics on each box that you have provided information to get into.


