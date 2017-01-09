# Security Enhanced linux


+ Arquivo de configuração

```text
/etc/sysconfig/selinux
```

+ Selinux Status

```text
/usr/sbin/sestatus
```

+ Selinux Enforce

```text
/usr/sbin/getenforce
```

## Conceitos do SELinux

### Labeling

```text
  1. Files, processes, ports, etc.,

  2. For files and directories, labels are stored as extended attributes on the filesystem

  3. For processes, ports, etc., the kernel manages theses labels.
```

Formato:

```text
user:role:type:level(optional)
```

Security Context Httpd

ls -dZ /etc/httpd/

```text
drwxr-xr-x. root root system_u:object_r:httpd_config_t:s0 /etc/httpd/
```

ls -dZ /var/log/httpd/

```text
drwx------. root root system_u:object_r:httpd_log_t:s0 /var/log/httpd/
```

ls -dZ /var/www/html

```text
drwxr-xr-x. root root system_u:object_r:httpd_sys_content_t:s0 /var/www/html
```

ps axZ | grep httpd

```text
system_u:system_r:httpd_t:s0      812 ?        Ss     0:35 /usr/sbin/httpd -DFOREGROUND
system_u:system_r:httpd_t:s0     8520 ?        S      0:00 /usr/sbin/httpd -DFOREGROUND
system_u:system_r:httpd_t:s0     8521 ?        S      0:00 /usr/sbin/httpd -DFOREGROUND
system_u:system_r:httpd_t:s0     8522 ?        S      0:00 /usr/sbin/httpd -DFOREGROUND
system_u:system_r:httpd_t:s0     8523 ?        S      0:00 /usr/sbin/httpd -DFOREGROUND
system_u:system_r:httpd_t:s0     8524 ?        S      0:00 /usr/sbin/httpd -DFOREGROUND
```

ss -tlZ | grep http

```text
LISTEN     0      128       :::http                    :::*                     users:(("httpd",pid=8524,proc_ctx=system_u:system_r:httpd_t:s0,fd=4),("httpd",pid=8523,proc_ctx=system_u:system_r:httpd_t:s0,fd=4),("httpd",pid=8522,proc_ctx=system_u:system_r:httpd_t:s0,fd=4),("httpd",pid=8521, proc_ctx=system_u:system_r:httpd_t:s0,fd=4),("httpd",pid=8520,proc_ctx=system_u:system_r:httpd_t:s0,fd=4),("httpd",pid=812,proc_ctx=system_u:system_r:httpd_t:s0,fd=4))
```

semanage port -l | grep -i http

```text
http_cache_port_t              tcp      8080, 8118, 8123, 10001-10010
http_cache_port_t              udp      3130
http_port_t                    tcp      80, 81, 443, 488, 8008, 8009, 8443, 9000
pegasus_http_port_t            tcp      5988
pegasus_https_port_t           tcp      5989
```

File transitions

Um processo, dhclient, executando com o label *dhclient_t* cria os arquivos, resolve.conf, _labeled_ como *net_conf_t* no diretório /etc/ labeled como etc_t. Sem uma transação, /etc/resolv.conf herdaria o _label_ *etc_t*

Mudança de contexto

O SELinux possui ferramentas como *_chcon_* ou *_restorecon_* para mudar o contexto do arquivo;
Os Contextos são definidos durante a criação do arquivos, baseado no contexto do diretório pai;
O processo de login configura um contexto padrão;

SELinux Manage

1. node
2. file contexto
3. boolean
4. permissive state
5. dontaudit


Get SELinux boolean value

getsebool -a | grep  -i httpd

```text
httpd_anon_write --> off
httpd_builtin_scripting --> on
httpd_can_check_spam --> off
httpd_can_connect_ftp --> off
httpd_can_connect_ldap --> off
httpd_can_connect_mythtv --> off
httpd_can_connect_zabbix --> off
```

Dependências

```text
yum install policycoreutils-python
yum install setroubleshoot setroubleshoot-server
```

### Laboratório: SELinux Apache2 - UserDIR Forbiden

No apache é habilitado a configuração _userdir_, permitindo que seja possível acessar páginas _html_ no diretório home do usuário; contudo, quando tentamos acessar a página o Apache retorna o error Forbiden. Isso acontece por que uma plítica do SELinux proibiu o acesso.
O arquivo de _log_ _/var/log/messages_ contém as informações adicionais a respeito do incidente:

+ Execute o comando _sealert -l UUID_ descrito no log;
+ O resultado do comando _sealert_ demonstra¹ como solucionar o problema;
+ Implemente uma solução² proposta;

1. Resultado do comando *_sealert -l UUID_*

```text
SELinux is preventing httpd from read access on the directory public_html.

*****  Plugin catchall_boolean (32.5 confidence) suggests   ******************

If you want to allow httpd to read user content
Then you must tell SELinux about this by enabling the 'httpd_read_user_content' boolean.
You can read 'None' man page for more details.
Do
setsebool -P httpd_read_user_content 1

*****  Plugin catchall_boolean (32.5 confidence) suggests   ******************

If you want to allow httpd to unified
Then you must tell SELinux about this by enabling the 'httpd_unified' boolean.
You can read 'None' man page for more details.
Do
setsebool -P httpd_unified 1

*****  Plugin public_content (32.5 confidence) suggests   ********************

If you want to treat public_html as public content
Then you need to change the label on public_html to public_content_t or public_content_rw_t.
Do
# semanage fcontext -a -t public_content_t 'public_html'
# restorecon -v 'public_html'

*****  Plugin catchall (4.5 confidence) suggests   ***************************

If you believe that httpd should be allowed read access on the public_html directory by default.
Then you should report this as a bug.
You can generate a local policy module to allow this access.
Do
allow this access for now by executing:
# ausearch -c 'httpd' --raw | audit2allow -M my-httpd
# semodule -i my-httpd.pp


Additional Information:
Source Context                system_u:system_r:httpd_t:s0
Target Context                unconfined_u:object_r:httpd_user_content_t:s0
Target Objects                public_html [ dir ]
Source                        httpd
Source Path                   httpd
Port                          <Unknown>
Host                          labz.localhost.local
Source RPM Packages
Target RPM Packages
Policy RPM                    selinux-policy-3.13.1-102.el7_3.7.noarch
Selinux Enabled               True
Policy Type                   targeted
Enforcing Mode                Enforcing
Host Name                     labz.localhost.local
Platform                      Linux labz.localhost.local
                              3.10.0-514.2.2.el7.x86_64 #1 SMP Tue Dec 6
                              23:06:41 UTC 2016 x86_64 x86_64
Alert Count                   3
First Seen                    2017-01-09 13:44:31 BRT
Last Seen                     2017-01-09 15:02:26 BRT
Local ID                      4f9b4e4b-274d-40a6-bc50-15c34561d04f

Raw Audit Messages
type=AVC msg=audit(1483984946.285:56438): avc:  denied  { read } for  pid=31016 comm="httpd" name="public_html" dev="dm-0" ino=1707525 scontext=system_u:system_r:httpd_t:s0 tcontext=unconfined_u:object_r:httpd_user_content_t:s0 tclass=dir


Hash: httpd,httpd_t,httpd_user_content_t,dir,read
```

2. Solução proposta

```text
setsebool -P httpd_read_user_content 1
```

### Laboratório: SELinux Apache2 - Web content

Mover o conteúdo web localizado no _home_ do usuário para o _DocumentRoot_ do site


Lista de configurações locais

cat /etc/selinux/targeted/active/booleans.local 



```text
# This file is auto-generated by libsemanage
# Do not edit directly.

httpd_read_user_content=1
```

+ Enforcement
