---
layout: post
title:  "Permission denied on accessing host directory in Docker container"
date:   2015-06-05 17:33:05
categories: selinux docker
---

If you running Docker with Selinux set for Type Enforcement, all files in a container are labeled by default as `svirt_sandbox_file_t`.

To use the directory in Docker container, change the label for `svirt_sandbox_file_t`.

Example:

{% highlight bash %}
~/Work ❯❯❯ pwd
/home/lborguetti/Work
~/Work ❯❯❯ mkdir -p test
~/Work ❯❯❯ docker run -t -i --rm -v ~/Work/test:/test busybox /bin/sh -c "cd /test; touch a && echo Ok"
touch: a: Permission denied

~/Work ❯❯❯ ls -Zd ~/Work/test
unconfined_u:object_r:user_home_t:s0 /home/lborguetti/Work/test

~/Work ❯❯❯ sudo chcon -R -t svirt_sandbox_file_t ~/Work/test
[sudo] password for lborguetti:

~/Work ❯❯❯ ls -Zd ~/Work/test
unconfined_u:object_r:svirt_sandbox_file_t:s0 /home/lborguetti/Work/test

~/Work ❯❯❯ docker run -t -i --rm -v ~/Work/test:/test busybox /bin/sh -c "cd /test; touch a && echo Ok"
Ok
{% endhighlight %}
