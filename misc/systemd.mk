list-units:
	systemctl list-units

# systemctl list-units net*
# *.service
list-units:
	systemctl list-units-files

status: name=docker
status:
	systemctl status $(name)

is-enabled: name=docker
is-enabled:
	systemctl is-enabled $(name)

show:
	systemctl show
