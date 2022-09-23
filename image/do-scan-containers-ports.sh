#!/bin/bash
# this script will scan used docker containers published ports
# output is stdout


# fonction inspired by:
# https://gist.github.com/ipedrazas/2c93f6e74737d1f8a791
function dip() {
        _print_container_info() {
            local container_id
            local container_ports
            local container_host
            local container_name
            local container_image
            container_id="${1}"
        
            container_ports=( $(docker inspect --format '{{range $p, $conf := .HostConfig.PortBindings}}{{(index $conf 0).HostPort}} {{end}}' "$container_id") )
            container_name="$(docker inspect --format "{{ .Name }}" "$container_id" | sed 's/\///')"
            container_workdir="$(docker inspect --format '{{index .Config.Labels "com.docker.compose.project.working_dir" }}' "$container_id")"
            container_host="$(hostname -s)"
            container_image="$(docker inspect --format "{{ .Config.Image }}" "$container_id" | sed 's/\///')"
            printf "%-20s %-40s %-50s %-20s %-72s\n" "$container_host" "$container_workdir" "$container_name" "${container_ports[*]}" "$container_image"
        }

        local container_id
        container_id="$1"
        printf "%-20s %-40s %-50s %-20s %-72s\n" 'Container Host' 'Container Directory' 'Container Name' 'Container Ports' 'Container Image'
        if [ -z "$container_id" ]; then
            local container_id
            docker ps -a --format "{{.Names}} {{.ID}}" | sort | sed 's#^[^ ]\+ ##g' | while read -r container_id ; do
                _print_container_info  "$container_id"
            done
        else
            _print_container_info  "$container_id"
        fi
}

# run it!
dip
