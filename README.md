# Projeto de Gerenciamento de Backend Terraform

Este projeto Terraform provisiona os recursos AWS necessários para servir como backend para outros projetos Terraform.
Ele cria:
1.  Um bucket AWS S3 para armazenar arquivos de estado (`.tfstate`) do Terraform.
    - Versionamento habilitado.
    - Criptografia padrão SSE-S3 habilitada.
    - Acesso público bloqueado.
    - Bloqueio de estado (state locking) é gerenciado nativamente pelo S3.

## Pré-requisitos

*   Conta AWS configurada com as credenciais apropriadas.
*   Terraform CLI instalado (versão especificada em `providers.tf`).

## Como Usar

1.  **Clonar o repositório (se aplicável) ou criar os arquivos conforme descrito.**

2.  **Configurar Variáveis:**
    Crie um arquivo `terraform.tfvars` na raiz do projeto ou defina as variáveis via linha de comando.
    As variáveis necessárias são:
    *   `s3_bucket_name`: O nome globalmente único para o seu bucket S3.
        Exemplo: `s3_bucket_name = "meu-tf-backend-estados-12345abc"`
    *   `aws_region` (opcional, padrão: "us-east-1"): A região AWS onde os recursos serão criados.
        Exemplo: `aws_region = "sa-east-1"`

    Exemplo de arquivo `terraform.tfvars`:
    ```hcl
    s3_bucket_name      = "seu-nome-de-bucket-unico-aqui"
    aws_region          = "us-east-1"
    ```

3.  **Inicializar o Terraform:**
    Navegue até o diretório do projeto e execute:
    ```bash
    terraform init
    ```

4.  **Planejar as Mudanças:**
    Revise os recursos que o Terraform criará:
    ```bash
    terraform plan
    ```

5.  **Aplicar as Mudanças:**
    Provisione os recursos na sua conta AWS:
    ```bash
    terraform apply
    ```
    Confirme a aplicação digitando `yes` quando solicitado.

## Usando o Backend em Outros Projetos Terraform

Após aplicar este projeto, você receberá o nome do bucket S3 como saída.
Use este valor para configurar o bloco `backend "s3"` em seus outros projetos Terraform. O bloqueio de estado será tratado nativamente pelo S3, desde que `use_lockfile = true` esteja configurado no backend do projeto consumidor.


```terraform
terraform {
  backend "s3" {
    bucket         = "NOME_DO_BUCKET_S3_CRIADO" # Substitua pelo valor de output s3_bucket_name
    key            = "caminho/para/seu/estado.tfstate" # Ex: networking/terraform.tfstate
    region         = "SUA_REGIAO_AWS" # Ex: us-east-1
    encrypt        = true
    use_lockfile   = true
  }
}
```

Lembre-se de executar `terraform init` novamente em seus outros projetos após adicionar ou modificar a configuração do backend.