<icecast>
    <limits>
        <clients>{{ .limits.clients }}</clients>
        <sources>{{ .limits.sources }}</sources>
        <threadpool>{{ .limits.threadpool }}</threadpool>
        <queue-size>{{ .limits.queue_size }}</queue-size>
        <client-timeout>{{ .limits.client_timeout }}</client-timeout>
        <header-timeout>{{ .limits.header_timeout }}</header-timeout>
        <source-timeout>{{ .limits.source_timeout }}</source-timeout>
        <burst-on-connect>{{ .limits.burst_on_connect }}</burst-on-connect>
        <burst-size>{{ .limits.burst_size }}</burst-size>
    </limits>
    <pidfile>{{ .pidfile }}</pidfile>
    <authentication>
        <source-password>{{ .authentication.source_password }}</source-password>
        <relay-password>{{ .authentication.relay_password }}</relay-password>
        <admin-user>{{ .authentication.admin_user }}</admin-user>
        <admin-password>{{ .authentication.admin_password }}</admin-password>
    </authentication>

    <hostname>{{ .hostname }}</hostname>

    {{ range .listen_sockets }}
    <listen-socket>
        <port>{{ .port }}</port>
        {{ if .bind_address }}<bind-address>{{ .bind_address }}</bind-address>{{ end }}
    </listen-socket>
    {{ end }}

    {{ range .mounts }}
    <mount type="normal">
        <mount-name>{{ .name }}</mount-name>
        {{ if .username }}<username>{{ .username }}</username>{{ end }}
        {{ if .password }}<password>{{ .password }}</password>{{ end }}
        {{ if .max_listeners }}<max-listeners>{{ .max_listeners }}</max-listeners>{{ end }}
        {{ if .burst_size }}<burst-size>{{ .burst_size }}</burst-size>{{ end }}
        {{ if .fallback_mount }}<fallback-mount>{{ .fallback_mount }}</fallback-mount>{{ end }}
        {{ if .fallback_override }}<fallback-override>{{ .fallback_override }}</fallback-override>{{ end }}
        {{ if .intro }}<intro>{{ .intro }}</intro>{{ end }}
        {{ if .hidden }}<hidden>{{ .hidden }}</hidden>{{ end }}
        {{ if .no_yp }}<no-yp>{{ .no_yp }}</no-yp>{{ end }}
    </mount>
    {{ end }}

    <fileserve>{{ .fileserve }}</fileserve>

    <paths>
        <basedir>{{ .paths.basedir }}</basedir>
        <logdir>{{ .paths.logdir }}</logdir>
        <webroot>{{ .paths.webroot }}</webroot>
        <adminroot>{{ .paths.adminroot }}</adminroot>
        <alias source="/" dest="/status.xsl"/>
    </paths>

    <logging>
        <accesslog>{{ .logging.accesslog }}</accesslog>
        <errorlog>{{ .logging.errorlog }}</errorlog>
        <loglevel>{{ .logging.loglevel }}</loglevel>
        <logsize>{{ .logging.logsize }}</logsize>
    </logging>

    <security>
        <chroot>{{ .security.chroot }}</chroot>
        {{ if .security.changeowner }}
        <changeowner>
            <user>{{ .security.changeowner.user }}</user>
            <group>{{ .security.changeowner.group }}</group>
        </changeowner>
        {{ end }}
    </security>
</icecast>
