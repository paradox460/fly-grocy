# Grocy on Fly

These are my minimal changes to the [linuxserver.io grocy image](https://github.com/linuxserver/docker-grocy) to get it running on [fly.io][https://fly.io/]. They're mostly around resolving issues with linuxserver containers wanting to run at PID 1, which fly will not allow

[Grocy](https://grocy.info) is an ERP for your home. Aka a grocery list manager and inventory tracker, with other cool superpowers.

## Deploying

This is pretty much your standard fly docker container deployment. You'll need to edity `fly.toml` with nominal changes, i.e. changing app name to your preferred name and region to one geographically close to you.

You'll need to create a volume on fly, for grocy data to be stored in

```sh
flyctl volumes create grocy_data --size 1 --region den
```

Finally, once you've tried to start the app, you might notice it's not working. This is because nginx is misreading the `resolver.conf` file and interpreting the `::` in an IPv6 address as a port. Copy the contents of `modified-resolver.conf` over the file located at `/config/nginx/resolver.conf` and restart your app.
