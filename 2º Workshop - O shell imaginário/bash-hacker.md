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
    #Autor: Enilton Angelim
    #Data:  15/12/2016
    host=${1:-127.0.0.1}
    port=${2:-25}
    ehlo=${3}
    auth=${4}
    user=${5}
    pass=${6}
    exec 5<>/dev/tcp/$host/$port
    echo -e "$ehlo" >&5
    sleep 2
    echo -e "$auth" >&5
    wait
    echo -e "$user" >&5
    wait
    echo -e "$pass" >&5
    wait
    timeout 10 cat <&5
    exec 5>&-
};export -f loginOnSmtp

loginOnSmtp mail.foo.com.br 25 "ehlo foo.com.br\r" "auth login\r" "usernameBase64\r" "passwordBase64\r"
```

