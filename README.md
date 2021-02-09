
<h1 align="center">
    <a href="https://pt-br.reactjs.org/">🔗 Envio de e-mail ADVPL</a>
</h1>

<p align="center">🚀 Projeto envio de e-mail automático com link rastro de transportadora e Danfe XML Ee PDF em anexo.</p>

<p align="center"> O que o programa é capaz de fazer :checkered_flag:</p>
<p align="center"> :trophy: Gerar PDF da Danfe e xml  para envio de e-mail </p>
<p align="center"> > Status do Projeto: Em desenvolvimento :warning:</p>

FONTE-> ENVIMAIL.PRW -> função -> User Function EnvMail()
1. Configurar o SMTP para envio de relatórios por e-mail
2. Pesquisa com query para obter os dados: Montar query com as tabelas SF2, SA4 e SA1.
3. Monta corpo de e-mail com html.
4. Para gerar os arquivos anexo.
5. Enviando arquivos em anexo
6. Marcação no envio do e-mail
7. Links utilizados para estudo e pesquisa
8. Solução para envio automático


Etapas para Projeto E-mail automático link rastro e anexo de danfe em xml e pdf
1-Configurar o SMTP para envio de relatórios por e-mail- Exemplo de configuração utilizada para
este projeto
#Configuração no appserver.ini
[MAIL]
PROTOCOL=IMAP
TLSVERSION=1
SSLVERSION=3
TRYPROTOCOLS=0
AUTHLOGIN=1
AUTHPLAIN=1
AUTHNTLM=1
#Configuração no caminho -> Acesse o Configurador > Ambiente > E-mail/Proxy > Configurar


#Configuração no código fonte ENVIMAIL.PRW , função ENVMAIL()
oMai1Server:= TMai1Manager() :New() 
oMai1Server:SetUseTLS( . T. ) 
oMai1Server : SetUseSSL( 
conout( "Iniciando conexão Servidor") 
"$cMai1Server // remove a porta 
cMai1Server:=1eft( cMai1Server, at • ",cMai1Server)-1 ) 
endif 
oMai1Server:Init( " 
cMai1Server, cMai1Conta, cMai1Senha, B , 587 ) 
nErro 
oMai1Server:SetSmtpTimeout( 15 ) 
oMai IServer : smtpconnect() 
nErro 
//seta um tempo de time out com servidor 

oMai1Server : SetSMTPTimeout( 15 ) 
nErro 
if nErro e 
conout( "Tempo para ajuste do protocolo expirou em " 
endif 
+ cVa1ToChar( nTimeout )) 
oMai1Server:SMTPConnect() / 'realiza a conexão SMTP 
nErro 
if nErro 
conout( " Falha ao conectar no Servidor SMTP: 
+ oMai1Server:GetErrorString( nErro )) 
return . F. 
else 
endif 

conout("lnicio autenticação") 
if IMai1Auth 
//O método SMTPAuth ao tentar realizar a autenticação do usuário no servidor de e-mail 
oMai1Server:SmtpAuth( cMai1Conta, cMai1senha ) 
xRet 
if xRet e 
conout( "Could not authenticate on SMTP server: ' 
+ oMai1Server xRet )) 
oMai1Server : SMTPDi sconnect( ) 
RPCC1earEnv() 
return 
endif 
Endif 

Link help para construção da página Readme!
https://dev.to/reginadiana/como-escrever-um-readme-md-sensacional-no-github-4509







