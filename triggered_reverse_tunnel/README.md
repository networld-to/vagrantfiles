# Triggered Reverse SSH Tunnel

**Problem:** You want to access one of your hosts that is behind a firewall
that is not controlled by you, e.g. ISP blocks all incoming connections to
your IP.

**Short Solution:** Open a SSH reverse tunnel to a middleman server and
connect via this reverse tunnel from you client.

**Extended Solution:** This solution has multiple problems. One is the
security. You don't want to keep open an SSH connection forever. Second, what
happens if the middleman goes down. We will fix the security by opening a
temporary reverse tunnel whenever a host behind a specific domain is
reachable. This host we will provision via vagrant.

## Architecture

    --------------- (2)  .............  (1) ----------
    | Destination |----->| Temporary |<-----| Local  |
    |    Host     |<-----| Middleman |<-----| Client |
    ---------------  (4) .............  (3) ----------

1. On our local machine we start the process by bootstrapping the
*Temporary Middleman* server. For this we use the `bootstrap.sh` script. This
server must be reachable from the internet and the *Destination Host* must
have credentials to connect to this host, e.g. the ssh key.
2. The *Destination Host* polls a specific domain each X minutes, e.g. 5, and
opens a reverse proxy if the *Temporary Middleman* is reachable.
3. We connect from our *Local Client* with SSH, via *Temporary Middleman*, to
the Destination Host. For this we use the newly created connection between the
*Destination Host* and the *Temporary Middleman*.

