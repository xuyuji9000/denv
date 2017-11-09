IP:=$(shell terraform output ip)
CERT:=~/.ssh/pairs/aws.pem
ssh:
	@ssh ubuntu@$(IP) -i $(CERT)
