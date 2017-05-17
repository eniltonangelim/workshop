# Gerenciamento de Configuração

> Não falaremos sobre integração contínua

O workshop tem como objetivo apresentar os principios da _Gerência de configuração_:

+ Entender os processos e os procedimentos;
+ Conhecer o essencial para desenvolver um gerenciamento de versão;
+ Entender a diferença entre versionamento e ~~release~~ lançamento;

*_Gerenciamento de mudança_*

Mensurar o custo e avaliar o impacto da mudança, e decidir _se_ e _quando_ a mudança deve ser implementada

*_Gerenciamento de versão_*

Evitar que haja conflito durante o desenvolvimento de uma nova funcionalidade, garantindo que um componente do sistema interfira em outro.

*_Compilar o sistema_*

Processo de unificação e compilação dos componentes para criar um sistema executável.

*_Gerenciamento de ~~release~~ lançamento_*

Manter um histórico de _releases_ que foram entregues aos clientes.

*_Termos_*

Tabela com os termo essenciais

| Termo     | Explanação    |
| --------- |:-------------:|
| Branching | É a criação de uma nova linha de desenvolvimento apartir de uma versão em um _branch_. São desenvolvidos separadamente.
| Merging   | Nova versão de um component apartir da combinação de duas _branches_  |

## Modelo evolutivo

Um Software sempre muda, exemplo a correção de um *_bug_* ou *_falha_*. No modelo de desenvolvimento evolutivo o sistema fica mais vulnerável à falhas, pois a janela de denvolvimento e atualização são mais curtas. Existem meios para diminuir o impacto que um _bug_ causa, como por exemplo testes automatizados. (Integração Contínua)

## A Ferramenta

Gerenciamento de configuração é um conjunto de políticas, processos e ferramentas. Sem uma ferramenta ficará dificil ter o controle sobre as versões e releases do software, pois não será possível acompanhar o fluxo de desenvolvimento do time.
O *_gitlab_* é a nossa ferramenta com a melhor relação custo-benefício, possibilitando:

+ Avaliação do código;
+ Publicação de documentos;
+ Controle de release;
+ Controle de mudança;
+ Desempenho da equipe;
+ Produtividade;
+ Teste automatizado;

## Product Backlog (Kanban board)

Técnica que utiliza cartões como meio de sinalização de como estar o andamento do projeto.

No gitlab por padrão temos o `backlog`, termo conhecido do método ágil para listar a prioridade do cliente.

## Workflow

```text
             Release v1.0.0                                      Release v1.1.0                             Release v1.1.1 
            º--------------                                     º--------------                            º---------------
master:  --(*)-------------------------------------------------[*]-----------------(-)-------------------[*]---->
            \                                                  /                    \                    /
             \                                                /                      \                  / 
hotfix:  -----\----------------------------------------------/-----------------------(o)--------------(o)
               \                                            /                                           \
develop:  º----[*]-------(o)---------[o]------------[o]----(o)------------------------------------------(*)----------------> 
                 \ Is#1   \          /              /                                                    |
issues:           º--------\-------(o)-------------/---------->                                          |
                            \ Is#2                /                                                      |
                             º------------------(o)----------->                                          |
                                                                                                        /º\
                                                                                                      .-m-m-.
                                                                                                      : ??? :
                                                                                                      .......
```

Home: `https://gitlab.f13.com.br:7443/puppet/f13-assp/boards`

Home: ![assp board](http://api.qrserver.com/v1/create-qr-code/?color=000000&bgcolor=FFFFFF&data=https%3A%2F%2Fgitlab.f13.com.br%3A7443%2Fpuppet%2Ff13-assp%2Fboards&qzone=1&margin=0&size=150x150&ecc=L)