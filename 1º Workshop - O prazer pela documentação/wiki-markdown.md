# Markdown

Markdown é uma ferramenta que converte texto para html, permitindo que você crie conteúdo estilizado usando apenas o formato de texto plano.

Duas coisas sobre o termo _Markdown_ precisam ser esclarecidas:

+ Markdown é um padrão de formatação;
+ Markdown é uma ferramenta que converte texto plano para HTML;

## Objetivo

O objetivo primordial de design para a sintaxe de formatação do _Markdown_ é torná-la o mais legível possível.

## Inspiração

A inspiração para a sintaxe do Markdown é o formato do e-mail. A sintaxe do Markdown destina-se a uma finalidade: para ser usada como um formato para escrever para a web.

## Regras

+ MD001 header-increment - Header levels should only increment by one level at a time
+ MD002 first-header-h1 - First header should be a top level header
+ MD003 header-style - Header style
+ MD004 ul-style - Unordered list style
+ MD005 list-indent - Inconsistent indentation for list items at the same level
+ MD006 ul-start-left - Consider starting bulleted lists at the beginning of the line
+ MD007 ul-indent - Unordered list indentation
+ MD009 no-trailing-spaces - Trailing spaces
+ MD010 no-hard-tabs - Hard tabs
+ MD011 no-reversed-links - Reversed link syntax
+ MD012 no-multiple-blanks - Multiple consecutive blank lines
+ MD013 line-length - Line length
+ MD014 commands-show-output - Dollar signs used before commands without showing output
+ MD018 no-missing-space-atx - No space after hash on atx style header
+ MD019 no-multiple-space-atx - Multiple spaces after hash on atx style header
+ MD020 no-missing-space-closed-atx - No space inside hashes on closed atx style header
+ MD021 no-multiple-space-closed-atx - Multiple spaces inside hashes on closed atx style header
+ MD022 blanks-around-headers - Headers should be surrounded by blank lines
+ MD023 header-start-left - Headers must start at the beginning of the line
+ MD024 no-duplicate-header - Multiple headers with the same content
+ MD025 single-h1 - Multiple top level headers in the same document
+ MD026 no-trailing-punctuation - Trailing punctuation in header
+ MD027 no-multiple-space-blockquote - Multiple spaces after blockquote symbol
+ MD028 no-blanks-blockquote - Blank line inside blockquote
+ MD029 ol-prefix - Ordered list item prefix
+ MD030 list-marker-space - Spaces after list markers
+ MD031 blanks-around-fences - Fenced code blocks should be surrounded by blank lines
+ MD032 blanks-around-lists - Lists should be surrounded by blank lines
+ MD033 no-inline-html - Inline HTML
+ MD034 no-bare-urls - Bare URL used
+ MD035 hr-style - Horizontal rule style
+ MD036 no-emphasis-as-header - Emphasis used instead of a header
+ MD037 no-space-in-emphasis - Spaces inside emphasis markers
+ MD038 no-space-in-code - Spaces inside code span elements
+ MD039 no-space-in-links - Spaces inside link text
+ MD040 fenced-code-language - Fenced code blocks should have a language specified
+ MD041 first-line-h1 - First line in file should be a top level header
+ MD042 no-empty-links - No empty links
+ MD043 required-headers - Required header structure

## Propriedades

### Parágrafo

Um Parágrafo é simplesmente uma ou mais linhas de texto consecutivas, separados
por uma ou mais linha em branco.

### Cabeçalho

Adicione o caractere # para especificar o cabeçalho.

### Citação (blockquotes)

Use o caractere **\>** para criar uma citação

### Listas

Markdown suporta listas ordenadas e não-ordenadas

Para listas não-ordenadas: asterisco(*), soma(+), e hífen.
Para listas ordenadas: sequencia númerica seguido pelo ponto final.

### Blocos de código

Recurso usado para destacar um código fonte. Produza um bloco simplemente usando a indentação para cada linha do conteúdo, ou usando a estrutura abaixo.

```php
class Main {
    _construct_(){};
}
```

### Linha horizontal (Horizontal Rules)

Para reproduzir uma linha horinzontal escreva três ou mais hífens, asteriscos, or underline seguidos na mesma linha.

### Link

O Markdown suporta dois estilos de link: inline e reference.

## Exemplo

---

![lxc][lxcimage]

[lxcimage]: http://cloudacademy.com/blog/wp-content/uploads/2016/02/lxc.png

# Documentação

> Exemplo: O conteúdo abaixo é ilustrativo


## Create: Ubuntu Xenial

```bash
lxc-create -t ubuntu -n depTestZimbraUbuntu16 -- -r xenial
```

## Create: Centos 7

```bash
lxc-create -n prodZimbraCentos7 -t download -- -d centos -r 7 -a amd64
```

Altera a senha

```bash
chroot /var/lib/lxc/prodZimbraCentos7/rootfs/ passwd
```

## Storage

vim  /var/lib/lxc/prodZimbraCentos7/config

```text
lxc.mount.entry0 = /dev/mapper/VG_DADOS_03-vg_dados_03_lv_prodZimbraCentos_opt /var/lib/lxc/prodZimbraCentos7/rootfs/opt ext4 errors=remount-ro 0 0
```

## Network

vim  /var/lib/lxc/prodZimbraCentos7/config

```text
lxc.network.link = lxcbr1
```

## Container Limits

CPU: https://www.mjmwired.net/kernel/Documentation/cgroups/cpusets.txt

Memory: https://www.mjmwired.net/kernel/Documentation/cgroups/memory.txt

vim  /var/lib/lxc/prodZimbraCentos7/config

```bash
lxc.cgroup.cpuset.cpus = 5-6
lxc.cgroup.memory.soft_limit_in_bytes = 268435456
lxc.cgroup.memory.limit_in_bytes = 2684354560
```

## DNS

+ Nameserver: 192.168.124.18
+ Zone: test.ztool.com.br
+ IP: 189.90.18.75

## Container: Info

prodZimbraCentos7

+ IP: 192.168.124.246
+ Hostname: mail.test.ztool.com.br
+ Suite: Zimbra 8.7.1
+ Credencial:
    1. Admin: lxcCon_eduldm@31f
    2. Root: belmpsc@31f
+ CPUs: 2
+ Memory: 2.5G

depTestZimbraCentos7

+ IP: 192.168.124.46
+ Hostname: mail1.deploy.ztool.com.br
+ Suite: Zimbra 8.7.1
+ Credencial:
    1. Admin: lxcCon_eduldm@31f
    2. Root: belmpsc@31f
+ CPUs: 2
+ Memory: 2G

depTestZimbraUbuntu16

+ IP: 192.168.124.47
+ Hostname: mail2.deploy.ztool.com.br
+ Suite: Zimbra 8.7.1
+ Credencial:
    1. Admin: lxcCon_eduldm@31f
    2. f13: belmpsc@31f
+ CPUs: 2
+ Memory: 2G

prodZtoolCentos7

+ IP: 192.168.124.245
+ Hostname: zweb.test.ztool.com.br
+ Suite: ---
+ Credencial:
    1. Root: belmpsc@31f
+ CPUs: 2
+ Memory: 1 GB

depTestZtoolUbuntu16

+ IP: 192.168.124.248
+ Hostname:
+ Suite: ---
+ Credencial:
    1. f13: belmpsc@31f
+ CPUs: 2
+ Memory: 1 GB

depTestZtoolCentos7

+ IP: 192.168.124.249
+ Hostname:
+ Suite: ---
+ Credencial:
    1. root: belmpsc@31f
+ CPUs: 2
+ Memory: 1 GB

Links:

1. Documentação do [lxc]

[lxc]: https://linuxcontainers.org/lxc/documentation/ 'lxc'