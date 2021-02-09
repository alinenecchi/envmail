#Include "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"

// ##################################################################################
//                                                                                 ##
// ------------------------------------------------------------------------------- ##
// Referencia: Envio de email usando o fonte LFDANFE.PRW função zGerDanfe()        ##
// Parâmetros: Nenhum                                                              ##
// Retorno...: Nenhum                                                              ##
// Tipo......: (X) Programa  ( ) Gatilho  () Ponto de Entrada                      ##
// ------------------------------------------------------------------------------- ##
// Autor.....:  ALINE RIBEIRO                                                      ##
// Data......:                                                                     ##
// Objetivo..: Envio de email rastro transportadora e danfe em anexo               ##
//                                                                                 ##
// ##################################################################################

User Function EnvMail()
    Local mtarea:= getarea()
    Local lMailAuth
    Local cMailServer
    Local cMailConta
    Local cMailSenha
    Local cMailRem
    Local cPara // criar parametro para email - ou extrair do banco de dados - tabela Clientes
    Local cMensagem:= ""
    local cAssunto:= ""
    Local cFilial // Extrair do Banco de Dados  ou criar pergunte com parametros 
    Local cEmpresa // Extrair do Banco ou criar pergunte com parametros 
    

    Local nErro:= 0
    Local nRegQry :=0 
    Local xRet

    Local oMailServer
    Local oMessage

    PREPARE ENVIRONMENT EMPRESA 'cEmpresa' FILIAL 'cFilial' TABLES 'SF2,SA1,SA2,SD2,SF3,SF4,SB1,SF1,SD1'  MODULO 'FAT'

    cMailServer := Alltrim(SuperGetMV( "MV_RELSERV" )) // verificar se os parametros ja existem , se não deve criar
    cMailConta  := Alltrim(SuperGetMv( "MV_RELACNT" ))
    cMailSenha  := Alltrim(SuperGetMv( "MV_RELPSW" ))
    lMailAuth   := SuperGetMv( "MV_RELAUTH",,.T. )
    cMailRem    :=Alltrim(SuperGetMv( "MV_FROMRT" )//Criar parametro para guardar email remetente


    oMailServer:= TMailManager():New() // Estancia a classe 
    oMailServer:SetUseTLS( .T. )
    oMailServer:SetUseSSL( .F. )

    conout("Iniciando conexão Servidor")

    if ":"$cMailServer // remove a porta
        cMailServer:=left( cMailServer, at (":",cMailServer)-1 )
    endif
    
    nErro := oMailServer:Init( "", cMailServer, cMailConta, cMailSenha, 0 , 587 ) //função init para setar os dados.
    oMailServer:SetSmtpTimeout( 15 )      //seta um tempo de time out com servidor
    nErro := oMailServer:smtpconnect()
    
    conout("Conectado ao servidor email")
    if nErro != 0
        conout("Falha na inicialização do servidor SMTP : " + oMailServer:GetErrorString( lfRet ))
        return .F.
    endif

    nErro := oMailServer:SetSMTPTimeout( 15 )
    if nErro != 0
        conout("Tempo para ajuste do protocolo expirou em " + cValToChar( nTimeout ))
    endif
    
    nErro := oMailServer:SMTPConnect() //realiza a conexão SMTP
    if nErro != 0
        conout("Falha ao conectar no Servidor SMTP: " + oMailServer:GetErrorString( nErro ))
        return .F.
    else
    endif

    conout("Inicio autenticação")
    if lMailAuth  //O método SMTPAuth ao tentar realizar a autenticação do usuário no servidor de e-mail
        xRet := oMailServer:SmtpAuth( cMailConta,cMailsenha )
        if xRet <> 0
            conout("Could not authenticate on SMTP server: " + oMailServer:GetErrorString( xRet ))
            oMailServer:SMTPDisconnect()
            RPCClearEnv()
            return
        endif
    Endif
    
    oMessage:=TMailMessage():New()  //Apos a conexão, cria o objeto da mensagem
    oMessage:Clear()
    //continua 



    conout("Fim do programa")
    RestArea(mtarea) 
    dbCloseAll()
    RPCClearEnv()
Return