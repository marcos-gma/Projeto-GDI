## Tabelas Independentes

| Categoria     | Tabela      | Dependências |
|---------------|-------------|--------------|
| INDEPENDENTES | Endereco    | Nenhuma      |
| INDEPENDENTES | Sala_visita | Nenhuma      |

## Tabelas Dependentes

| Categoria   | Tabela          | Dependências                          |
|-------------|-----------------|---------------------------------------|
| DEPENDENTES | Funcionario     | Endereco                              |
| DEPENDENTES | Diretor         | Funcionario                           |
| DEPENDENTES | Superintendente | Funcionario, Diretor                  |
| DEPENDENTES | Ala             | Superintendente                       |
| DEPENDENTES | Telefone        | Funcionario                           |
| DEPENDENTES | Guarda          | Funcionario (para supervisão, se aplicável) |
| DEPENDENTES | Detento         | Nenhuma                               |
| DEPENDENTES | Sentenca        | Detento                               |
| DEPENDENTES | Crime           | Sentenca                              |
| DEPENDENTES | Visitante       | Detento                               |
| DEPENDENTES | Cela            | Tipo_Cela                             |
| DEPENDENTES | Visita          | Detento                               |
| DEPENDENTES | Entrada         | Visitante                             |
| DEPENDENTES | Lugar           | Sala_visita                           |
| DEPENDENTES | Possui          | Detento, Cela, Ala                    |
