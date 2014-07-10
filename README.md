# Capistrano::SafeDeployTo

A simple Capistrano plugin that:
- ensures the deployment directory exists on the server
- ensures proper deployment directory ownership

With this, your deployment should **never fail** because you forgot to create a
deployment directory for your new app on the server.

Works with Capistrano 3. Does **not work** with Capistrano 2.

### About

You set a Capistrano deployment directory with a `deploy_to` setting. By default
the value of `deploy_to` is `"/var/www/#{app_name}"`.

Your first deploy will **fail** if the `deploy_to` directory does not exist,
you're not deploying as `root` and your deploy user does not have rights to
create a deploy directory.

And yes, deployment to default `deploy_to` directory **will most likely fail**.

That is easy to fix, right? A quick:
- `ssh yourserver`
- `sudo mkdir -p /var/www/app_name`
- `sudo chown deploy:deploy /var/www/app_name`

Except that is painful, unnecessary and there's no need to manually `ssh` to the
server to deploy apps!

There are other solutions to this problem (Chef, Ansible), but if you'd like to
solve it via Capistrano, read on.

### Usage

Install with:

    gem 'capistrano', '~> 3.1'
    gem 'capistrano-safe-deploy-to', '~> 1.1.1'

then:

    $ bundle install

and then add to `Capfile`:

    require 'capistrano/safe_deploy_to'

And you're done. `$ bundle exec cap production deploy` should just work!
(or at least it won't fail because directories don't exist).

There are no configuration options (thank God!)

### How it works

`capistrano-safe-deploy-to` hooks to `before 'deploy:check'` task. It:

1. creates s `deploy_to` directory with `sudo mkdir -p <your_deploy_dir>`
2. gives proper ownership to deploy dir with
`sudo chown <deploy_user>:<deploy_user_group> <your_deploy_dir>`

It's simple, but you don't have to do or think about it. Let the computers
work for you!

### More Capistrano automation?

If you'd like to streamline your Capistrano deploys, you might want to check
these zero-configuration, plug-n-play plugins:

- [capistrano-unicorn-nginx](https://github.com/bruno-/capistrano-unicorn-nginx)<br/>
no-configuration unicorn and nginx setup with sensible defaults
- [capistrano-postgresql](https://github.com/bruno-/capistrano-postgresql)<br/>
plugin that automates postgresql configuration and setup
- [capistrano-rbenv-install](https://github.com/bruno-/capistrano-rbenv-install)<br/>
would you like Capistrano to install rubies for you?

### License

[MIT](LICENSE.md)
