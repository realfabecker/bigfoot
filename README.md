# Bigfoot

**Bigfoot** é um conjunto de estruturas base projetado para acelerar a inicialização de novos projetos. Com ele, você pode rapidamente configurar um ambiente de desenvolvimento sólido e organizado.

## Por que usar o Bigfoot?

- **Boilerplates prontos**: Diversos templates disponíveis para diferentes stacks.
- **Rápido e eficiente**: Clone apenas o que você precisa com `sparse-checkout`.
- **Integração com Kevin**: Automação simplificada para inicializar novos projetos.
- **Aberto para contribuições**: Ajude a melhorar o projeto!

## Início Rápido

A forma mais simples de começar um projeto é clonando apenas a base necessária:

```bash
# Clone apenas a estrutura necessária
GIT_REPO=git@github.com:realfabecker/bigfoot.git
PROJECT_TYPE=typescript

mkdir -p /tmp/bigfoot && git -C /tmp clone --depth=1 --no-checkout $GIT_REPO /tmp/bigfoot

git -C /tmp/bigfoot sparse-checkout init

git -C /tmp/bigfoot sparse-checkout set $PROJECT_TYPE

git -C /tmp/bigfoot checkout

# Move o template para o diretório desejado
mv /tmp/bigfoot/$PROJECT_TYPE .
```

## Início Recomendado (com Kevin)

Se você utiliza o [kevin][link-kevin], pode simplificar ainda mais a inicialização do projeto com um comando personalizado:

### Configuração no arquivo `.yaml` do Kevin:

```yaml
commands:  
  - name: "bootstrap"
    short: "Inicializa um projeto com um boilerplate"
    flags:
      - name: "project"
        usage: "Nome do template do projeto"
        required: true
      - name: "directory"
        usage: "Diretório de destino"
        required: true
    cmd: |
      set -e
      big_dir=$(mktemp)
      
      echo "Baixando template do repositório..."
      rm -rf $big_dir && git -C /tmp clone --depth=1 --no-checkout git@github.com:realfabecker/bigfoot.git
      
      echo "Selecionando template..."
      git -C /tmp/bigfoot sparse-checkout init \
          && git -C /tmp/bigfoot sparse-checkout set {{ .GetFlag "project" }} \
          && git -C /tmp/bigfoot checkout
      
      echo "Movendo para o diretório de destino..."
      mv /tmp/bigfoot/{{ .GetFlag "project" }} {{ .GetFlag "directory" }}
```

### Execução simplificada:

```bash
kevin bootstrap -p typescript -d .
```

## Contribuindo

Quer ajudar a melhorar o **Bigfoot**? Confira nosso [guia][link-contrib] para saber como colaborar!

## Licença

Este projeto está sob a licença **MIT**. Confira os detalhes no arquivo [Licença][link-license].

[link-contrib]: https://github.com/realfabecker/.github/blob/main/.github/CONTRIBUTING.md
[link-kevin]: https://github.com/realfabecker/kevin
[link-license]: https://github.com/realfabecker/.github/blob/main/.github/LICENSE.md
