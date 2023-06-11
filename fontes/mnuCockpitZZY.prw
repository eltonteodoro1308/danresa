#include 'totvs.ch'
#include 'fwmvcdef.ch'

static function menudef()

	local aRet := {}

	aAdd( aRet, { 'Gerar Pedido'           , 'U_XINC410' , 0, 8, 0,,, } )
	aAdd( aRet, { 'Compatibilizar Cliente' , 'U_XINC980' , 0, 8, 0,,, } )
	aAdd( aRet, { 'Compatibilizar Produto' , 'U_XINC010' , 0, 8, 0,,, } )

return aRet

user function XINC980()

	Local aArea     := getArea()
	Local jEndereco := jsonObject():new()

	Private _cEndereco := ''
	Private _cBairro   := ''
	Private _cEstado   := ''
	Private _codMnIbge := ''


	if ZZY->ZZY_CLICMP

		apMsgInfo( 'Cliente já Compatibilizado !!!', 'Atenção !!!' )

	else

		dbSelectArea( 'ZZX' )
		ZZX->( dbSetOrder( 3 ) )

		if ZZX->( msSeek( xFilial('ZZX') + ZZY->ZZY_IDCLI ) )

			jEndereco:fromJson( ZZX->ZZX_ENDERE )

			_cEndereco := strTokArr2( jEndereco['endereco'], ',', .T. )[1]
			_cMunicipi := jEndereco['municipio']
			_cBairro   := jEndereco['bairro']
			_cEstado   := jEndereco['estado']
			_codMnIbge := right( cValToChar( jEndereco[ 'codigoMunicipioIbge' ] ), 5)

			dbSelectArea('SA1')
			FWExecView("Incluir","CRMA980",MODEL_OPERATION_INSERT,/*oDlg*/,/*bCloseOnOk*/,/*bOk*/,/*nPercReducao*/)

		else

			apMsgStop( 'Cliente não localizado na tabela ZZX.', 'Atenção !!!' )

		end if

	end if

	restArea( aArea )

return

user function XINC010()

	Local aArea := getArea()

	if ZZY->ZZY_PRDCMP

		apMsgInfo( 'Produto já Compatibilizado !!!', 'Atenção !!!' )

	else

		dbSelectArea( 'ZZV' )
		ZZV->( dbSetOrder( 1 ) )

		if ZZV->( msSeek( xFilial('ZZV') + ZZY->ZZY_PRODUT ) )

			A010INCLUI(/*cAlias*/,/*nReg*/,/*nOpc*/)

		else

			apMsgStop( 'Produto não localizado na tabela ZZV.', 'Atenção !!!' )

		end if

	end if

	restArea( aArea )

return

user function XINC410()

	Local nOpc := 3

	Private cCadastro  := "Atualização de Pedidos de Venda"
	Private INCLUI     := .T.
	Private aRotina    := FWLoadMenuDef( 'MATA410' )
/* 
	if ! ZZY->ZZY_CLICMP

		apMsgStop( 'Cliente não compatibilizado !!!!', 'Atenção !!!' )

		return

	end if

	if ! ZZY->ZZY_PRDCMP

		apMsgStop( 'Produto não compatibilizado !!!!', 'Atenção !!!' )

		return

	end if
 */
	A410Inclui(/*cAlias*/,/*nReg*/, nOpc /*,lOrcamento,nStack,aRegSCK,lContrat,nTpContr,cCodCli,cLoja,cMedPMS*/)

return

