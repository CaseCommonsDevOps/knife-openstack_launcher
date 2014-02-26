# Knife OpenStack Launcher

[![Build Status](https://travis-ci.org/greenalto/knife-ec2_launcher.png)](https://travis-ci.org/greenalto/knife-openstack_launcher)
[![Code Climate](https://codeclimate.com/github/greenalto/knife-ec2_launcher.png)](https://codeclimate.com/github/greenalto/knife-openstack_launcher)

A knife-openstack wrapper with support for YAML profiles

## Installation

Add this line to your Chef repository's Gemfile:

```ruby
gem 'knife-openstack_launcher',
    :git => 'git@github.com:greenalto/knife-openstack_launcher.git'
```

And then execute:

```shell
$ bundle
```

## Usage

Create a config/openstack.yml file in your Chef repository. Here's an example:

```yml
profiles:
  svn:
    ec2_security_groups:
      - "svn"
    run_list:
      - "role[svn]"
      - "role[base]"
    flavor: "t1.micro"
    image: "ami-f5998981"

  nfs_server:
    ec2_security_groups:
      - "cove"
    run_list:
      - "role[base]"
      - "role[nfs_server]"
    chef_environment: "prod"
    distro: "ubuntu12.04-gems"
```

To bootstrap a SVN server with the right security group, flavor and image,
launch from your Chef repository:

```shell
knife openstack server from profile svn.example.com --profile=svn
```


You can specify the path to a YAML config file:

```shell
knife openstack server from profile svn.example.com --profile=svn \
  --yaml-config=/path/to/config.yml
```

You can override anything that can be set when bootstrapping a node using
knife-openstack using the YAML profiles. See
[ec2_base](https://github.com/opscode/knife-ec2/blob/201850a938b3bece4719045786619ed9ad27ff0d/lib/chef/knife/ec2_base.rb#L37-L53)
and
[ec2_server_create](https://github.com/opscode/knife-ec2/blob/master/lib/chef/knife/ec2_server_create.rb#L42-L223)
for a complete reference.

You can also add any command-line switch from `knife ec2 server create --help`.
For example, if you want to create a more powerful SVN server in another region
as a one-time action:

```shell
knife openstack server from profile svn_us.example.com --profile=svn \
  --region=us-west-1 --flavor=m1.small
```

If you don't specify something in the profile, it is going to be taken from
your `.chef/knife.rb` or the defaults from the knife-ec2 plugin. For example:

```ruby
knife[:flavor]   = 'm1.small'
knife[:ssh_user] = 'ubuntu'
```

At the time of this writing:

* `aws_access_key_id`
* `aws_secret_key_id`
* `region`
* `flavor`
* `image`
* `security_groups`
* `security_group_ids`
* `associate_eip`
* `tags`
* `availability_zone`
* `chef_node_name`
* `ssh_key_name`
* `ssh_user`
* `ssh_password`
* `ssh_port`
* `ssh_gateway`
* `identity_file`
* `prerelease`
* `bootstrap_version`
* `distro`
* `template_file`
* `ebs_size`
* `ebs_optimized`
* `ebs_no_delete_on_term`
* `run_list`
* `json_attributes`
* `subnet_id`
* `private_ip_address`
* `host_key_verify`
* `bootstrap_protocol`
* `fqdn`
* `aws_user_data`
* `hint`
* `ephemeral`
* `server_connect_attribute`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
