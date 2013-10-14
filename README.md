packer-docker-chef-ubuntu
=========================

Example repository showing how to make a packer template which builds
ubuntu images with chef and docker installed. The goal of this repository
is to capture all the learnings about the best way to perform basic
infrastructure builds, so pull requests are most welcome.


Details
-------

In order to build instance store backed images you will need the your
AWS credentials. Also, because packer is still using the old AWS command
line utilities you will need to [generate and use] [1] X.509 keys. This
is [tracked] [2] and will hopefully be fixed soon.

There are a number of ways you can shoot yourself in the foot while
making images and this repository avoids all the ones I know about.
Since there is no good way to put comments in a json file, I feel
compelled to point out the inclusion of the inclusion of
`shutdown_command` for the vagrant builder. Packer does not
[currently] [3] warn if you do not have a command there, but without it
you will not be able to make an image.

There is a known [bug] [4] with vagrant post-processors for instance
images which prevents them from being run, which is why they are
disabled.

Since image names need to be unique, I use a timestamp suffix. You may
want to use something more meaningful.

As you experiment in building images, you will probably find it helpful
to set the `PACKER_CACHE` environment variable so that you can avoid
downloading the same large ISO images multiple times.


Configuration
-------------

The packer template needs the following variables to be specified

* `aws_region`
The region to launch and store the image in. Defaults to `us-west-1`
because that is what I use.

* `aws_s3_bucket`
The name of the S3 bucket into which your image is stored cannot contain
periods or be DNS like.

* `aws_access_key`
The AWS access key for provisioning. You probably want to keep this out
of your git history.

* `aws_secret_key`
The AWS secret key for provisioning. You probably want to keep this out
of your git history.

* `aws_account_id`
The AWS account ID for provisioning.

* `aws_x509_cert_path`
Path to an X.509 signing cert 

* `aws_x509_key_path`
Path to an X.509 private key



Building
--------

When you are building the images you need to supply the `aws_*`
variables. You can do this individually on the command line, or put them
all in a file, which is what I do to make my life easier.


Caveats
-------

The image created here has not been security hardened or audited in any
way. If you are using this for anything other than an example you almost
certainly want to lock the system down. There are a number of [good] [5] 
[starting] [6] [points] [7] [for] [8] securing a sever.


  [1]: http://docs.aws.amazon.com/IAM/latest/UserGuide/Using_UploadCertificate.html
  [2]: https://github.com/mitchellh/packer/issues/517 "Issue 517"
  [3]: https://github.com/mitchellh/packer/issues/498 "Issue 498"
  [4]: https://github.com/mitchellh/packer/issues/502 "Issue 502"
  [5]: http://www.nsa.gov/ia/_files/os/redhat/rhel5-guide-i731.pdf "NSA Guide to Securing Red Hat"
  [6]: http://www.debian.org/doc/manuals/securing-debian-howto/ "Securing Debian Manual"
  [7]: http://spenserj.com/blog/2013/07/15/securing-a-linux-server/ "Securing a Linux Server"
  [8]: https://news.ycombinator.com/item?id=6384603 "Hacker News on 'Securing a Linux Server'"
