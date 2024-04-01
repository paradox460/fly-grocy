# Grocy on Fly

These are my minimal changes to the [linuxserver.io grocy image](https://github.com/linuxserver/docker-grocy) to get it running on [fly.io](https://fly.io/). They're mostly around resolving issues with linuxserver containers wanting to run at PID 1, which fly will not allow

[Grocy](https://grocy.info) is an ERP for your home. Aka a grocery list manager and inventory tracker, with other cool superpowers.

## Deploying

This is pretty much your standard fly docker container deployment. You'll need to edity `fly.toml` with nominal changes, i.e. changing app name to your preferred name and region to one geographically close to you.

You'll need to create a volume on fly, for grocy data to be stored in

```sh
flyctl volumes create grocy_data --size 1 --region den
```

Finally, once you've tried to start the app, you might notice it's not working. This is because nginx is misreading the `resolver.conf` file and interpreting the `::` in an IPv6 address as a port. Copy the contents of `modified-resolver.conf` over the file located at `/config/nginx/resolver.conf` and restart your app.


## Why Fly?

There are a few reasons to run Grocy remotely, as opposed to on a home server, and a few advantages of picking Fly.io to do this.

Running it remotely allows you to use the various mobile apps, or access it from your phone's browser, while _at_ the store. Running it on a home server, you have to either have a public IP (dynamic or otherwise) and access it over that, or use a VPN of some sort. Android's approach to VPN handling leaves a lot to be desired; always on connections are unreasonably cumbersome. For non-technical people, the slight obstacle of having to turn on a VPN to access the grocery list is too obnoxious to ensure long term use.

There are many options for hosting Grocy, but Fly ultimately wins out on a few factors. There is a generous free tier, more than enough to run Grocy and a few other applications without paying anything, and Fly has a unique feature that will [shut down unused applications until they're used again](https://fly.io/docs/apps/autostart-stop/). This means that at 3 AM when no one is using your Grocy instance, you're not paying for it to be up and awaiting connections.
