# Commands

- get ubuntu 16.04 images

``` bash
aws ec2 describe-images --filters "Name=virtualization-type,Values=hvm" "Name=name,Values=*hvm-ssd*xenial*201703*"
```

