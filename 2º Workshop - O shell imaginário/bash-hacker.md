# 2º Workshop - O shell imaginário

Objetivo: Mostrar que é possível, sim, ser criativo no bash. Não sejas um decorador de opções.

## Dispositivos especiais

1. /dev/urandom

    Um *pseudo-device* que prover um método mais eficaz  para a geração de números pseudoaleatórios

2. *_/dev/tcp_*

    Um *pseudo-device* capaz de estabelecer uma conexão TCP

3. *_/dev/udp_*

    Um *pseudo-device* capaz de estabelecer uma conexão UDP (User Datagram Packet port)


> Nota: O bash deve ser compilado com a opção *--enable-net-redirections*

## Teste de conexão

+ Conectando ao serviço ssh

```bash
$ timeout 10 cat </dev/tcp/127.0.0.1/22
SSH-2.0-OpenSSH_5.9p1 Debian-5ubuntu1.8
```

+ Conectando ao servidor SMTP

```bash
$ timeout 10 cat </dev/tcp/127.0.0.1/25
220 foo.com.br ESMTP Postfix
```

+ Função para teste de conexão

```bash
function loginOnSmtp(){
    host=${1:-127.0.0.1}
    port=${2:-25}
    ehlo=${3}
    auth=${4}
    user=${5}
    pass=${6}
    mailFrom=${7}
    rcptTo=${8}
    data=${9}
    exec 5<>/dev/tcp/$host/$port
    echo -e "$ehlo" >&5
    sleep 2
    echo -e "$auth" >&5
    sleep 2
    echo -e "$user" >&5
    sleep 1
    echo -e "$pass" >&5
    sleep 1
    echo -e "$mailFrom" >&5
    sleep 1
    echo -e "$rcptTo" >&5
    sleep 1
    echo -e "DATA" >&5
    sleep 1
    echo -e "$data"  >&5
    sleep 1
    echo -e '\r\n.\r\n'  >&5
    sleep 1
    timeout 6 cat <&5
    exec 5>&-
}; export -f loginOnSmtp
```

loginOnSmtp mail.foo.com.br 25 "ehlo foo.com.br\r" "auth login\r" "usernameBase64\r" "passwordBase64\r" "mail from:...\r" "rcpt to:...\r" "Subject:...\r\r...data\r"

```text
220 mailservice01.foo.com.br ESMTP Postfix
250-mailservice01.foo..com.br
250-STARTTLS
250-SIZE 1048576000
250-VRFY
250-ENHANCEDSTATUSCODES
250-8BITMIME
250 DSN
334 VXNlcm5hbWU6
334 UGFzc3dvcmQ6
235 2.7.0 Authentication successful
```

+ Visualizando o redirecionamento

1. exec 5<>/dev/tcp/$host/$port
2. lsof -a -p $$ -d0,1,2,5

```text

COMMAND  PID    USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
bash    3981 enilton    0u   CHR  136,2      0t0    5 /dev/pts/2
bash    3981 enilton    1u   CHR  136,2      0t0    5 /dev/pts/2
bash    3981 enilton    2u   CHR  136,2      0t0    5 /dev/pts/2
bash    3981 enilton    5u  IPv4  48450      0t0  TCP 192.168.0.8:41250->mailservice01.f13.com.br:smtp (ESTABLISHED)


                  ---       +-----------------------+
standard input   ( 0 ) <----| 5                     |
                  ---       +-----------------------+

                  ---       +-----------------------+
standard output  ( 1 ) ---->| 5                     |
                  ---       +-----------------------+

                  ---       +-----------------------+
standard error   ( 2 ) ---->| /dev/pts/2            |
                  ---       +-----------------------+

                  ---       +-----------------------+
new descriptor   ( 5 ) ---->| connect               |
                  ---       +-----------------------+
```

## Transferência de dados

+ Servidor

```bash
while true; do
    filename=$(nc -l 5555)
    nc -l 5556 > $1/$(basename $filename)
done
```

+ Transferência

Nome do arquivo

```bash
echo eclipse.tar.gz >/dev/tcp/127.0.0.1/5555
```

Dados do arquivo

```bash
cat eclipse-jee-luna-SR2-linux-gtk-x86_64.tar.gz > /dev/tcp/127.0.0.1/5556
```

Hash md5 do arquivo original

```bash
be9391112776755e898801d3f3f51b74  eclipse-jee-luna-SR2-linux-gtk-x86_64.tar.gz
```

Hash md5 da cópia

```bash
be9391112776755e898801d3f3f51b74  /tmp/eclipse.tar.gz
```
