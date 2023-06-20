#include 'totvs.ch'
#include 'fwmvcdef.ch'

static function menudef()

	local aRet := {}

	aAdd( aRet, { 'Gerar Pedido'            , 'U_XINC410' , 0, 8, 0,,, } )
	aAdd( aRet, { 'Compatibilizar Cliente'  , 'U_XINC980' , 0, 8, 0,,, } )
	aAdd( aRet, { 'Compatibilizar Produto'  , 'U_XINC010' , 0, 8, 0,,, } )
	aAdd( aRet, { 'Visualizar Oportunidade' , 'U_viewZZY' , 0, 8, 0,,, } )

return aRet

user function XINC980()

	Local aArea     := getArea()
	Local jEndereco := jsonObject():new()
	local cSeekZZX  := ZZY->( xFilial( 'ZZV' ) + alltrim( ZZY_CLIENT ) )
	local cSeekSA1  := ''
	local lSeekSA1  := .F.
	local cCommand  := ''

	Private _cEndereco := ''
	Private _cBairro   := ''
	Private _cEstado   := ''
	Private _codMnIbge := ''

	dbSelectArea( 'ZZX' )
	ZZX->( dbSetOrder(3) )

	if ZZX->( msSeek( cSeekZZX ) .And.  cSeekZZX == xFilial( 'ZZX' ) + alltrim( ZZX_ID ) )

		cSeekSA1  := xFilial( 'SA1' ) + AllTrim( ZZX->( ZZX_CPF + ZZX_CNPJ ) )

		dbSelectArea( 'SA1' )
		SA1->( dbSetOrder( 3 ) )
		SA1->( lSeekSA1 := msSeek( cSeekSA1 ) .And. cSeekSA1 == A1_FILIAL + A1_CGC )

	end if

	if ZZY->ZZY_CLICMP .Or. lSeekSA1

		apMsgInfo( 'Cliente já Compatibilizado !!!', 'Atenção !!!' )

		// Marcar Oportunidade como cliente compatibilizado
		cCommand := " UPDATE " + retSqlName( 'ZZY' )
		cCommand += " SET ZZY_CLICMP = 'T' "
		cCommand += " WHERE ZZY_IDCLI = '" + ZZX->ZZX_ID + "' "

		if tcSqlExec(cCommand ) < 0

			autoGrLog( 'Erro ao gravar no Banco de Dados: ' + CRLF + TCSQLError() )
			mostraErro()

		end if

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

	Local aArea    := getArea()
	local cSeek    :=  ZZY->( xFilial( 'ZZZ' ) + allTrim( ZZY_PRODUT ) )
	local lSeekZZZ := .F.
	local cCommand := ''

	dbSelectArea( 'ZZZ' )
	ZZZ->( dbSetOrder( 2 ) ) //ZZZ_FILIAL+ZZZ_CDNECT+ZZZ_CDPROT
	ZZZ->( lSeekZZZ := msSeek( cSeek ) .And. cSeek == ZZZ_FILIAL + allTrim( ZZZ_CDNECT ) )

	if ZZY->ZZY_PRDCMP .Or. lSeekZZZ

		apMsgInfo( 'Produto já Compatibilizado !!!', 'Atenção !!!' )

		// Marcar Oportunidade como produto compatibilizado
		cCommand := " UPDATE " + retSqlName( 'ZZY' )
		cCommand += " SET ZZY_PRDCMP = 'T' "
		cCommand += " WHERE ZZY_PRODUT = '" + ZZV->ZZV_CODIGO + "' "

		if tcSqlExec(cCommand ) < 0

			autoGrLog( 'Erro ao gravar no Banco de Dados: ' + CRLF + TCSQLError() )
			mostraErro()

		end if

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

	Local nOpc      := 3
	Local aArea     := getArea()
	Local nPos      := 0
	Local lIndireta := .T.
	Local cSeekZZX  := ''
	Local cSeekSA1  := ''

	Private jSC5   := jsonObject():new()
	Private aSC6   := {}

	Private cCadastro  := "Atualização de Pedidos de Venda"
	Private INCLUI     := .T.
	Private aRotina    := FWLoadMenuDef( 'MATA410' )

	public _aLstOport := {}

	dbSelectArea('ZZX')
	ZZX->( dbSetOrder( 3 ) )

	dbselectarea('ZZZ')
	ZZZ->( dbSetOrder( 1 ) )

	ZZY->( DbGoTop() )

	do while ZZY->( ! eof() )

		if _oBrowseUp:isMark( _oBrowseUp:Mark() )

			aSize( _aLstOport, 0 )

			if empty( nPos := aScan( aLstOp, ZZY->ZZY_CODIGO ) )

				aAdd( _aLstOport, ZZY->ZZY_CODIGO )

			end if

			if empty( jSC5['CLIENTE'] )

				dbSelectArea( 'ZZX' )
				ZZX->( dbSetOrder( 3 ) )

				if ZZX->( msSeek( cSeekZZX := xFilial( 'ZZX' ) + allTrim( ZZY->ZZY_CLIENT ) ) .And.;
						cSeekZZX == ZZX_FILIAL + ZZX_ID )

					dbSelectArea( 'SA1' )
					SA1->( dbSetOrder( 3 ) )

					if SA1->( msSeek( cSeekSA1 := xFilial( 'SA1' ) + allTrim( ZZX->( ZZX_CPF + ZZX_CNPJ ) ) ) .And.;
							cSeekSA1 == A1_FILIAL + A1_CGC )

						jSC5['CLIENTE']  := SA1->A1_COD
						jSC5['LOJA']     := SA1->A1_LOJA
						jSC5['TIPO']     := SA1->A1_TIPO
						jSC5['CONDPAG']  := SA1->A1_COND
						jSC5['NATUREZA'] := SA1->A1_NATUREZ

					end if

				end if

			end if

			aAdd( aSC6, jsonObject():new() )

			aTail( aSc6 )['PRODUTO']              := posicione( 'ZZZ', 2, xFilial( 'ZZZ' ) + ZZY->ZZY_PRODUT, 'ZZZ_CDPROT' )
			aTail( aSc6 )['QUANTIDADE']           := ZZY->ZZY_QTDPRD
			aTail( aSc6 )['VALOR_UNITARIO']       := ZZY->ZZY_VLUNPD
			aTail( aSc6 )['OPORTUNIDADE']         := ZZY->ZZY_CODIGO
			aTail( aSc6 )['CLIENTE_OPORTUNIDADE'] := jSC5['CLIENTE']
			aTail( aSc6 )['LOJA_OPORTUNIDADE']    := jSC5['LOJA']
			aTail( aSc6 )['ITEM_OPORTUNIDADE']    := ZZY->ZZY_ITEM

	/*TODO Definir no item do pedido os seguintes itens
			descrição produto
			valor total
			tes saída
			armazém
			*/

     //TODO armazém padrão

		end if

		ZZY->( DbSkip() )

	end do

	if len( _aLstOport ) == 1

		lIndireta := aviso( 'Tipo de Venda', 'Informe o tipo de venda', { 'Direta', 'indireta' }, 3 ) == 2

	end if

	if lIndireta

		pergunte( 'NECINDIRET')

		jSC5['CLIENTE'] := MV_PAR01
		jSC5['LOJA']    := MV_PAR02

		for nPos := 1 to len( aSc6 )

			aSc6[ nPos ][ 'VALOR_UNITARIO' ] *= ( MV_PAR03/100 )

		next nPos

	end if

	A410Inclui(/*cAlias*/,/*nReg*/, nOpc /*,lOrcamento,nStack,aRegSCK,lContrat,nTpContr,cCodCli,cLoja,cMedPMS*/)

	restArea( aArea )

return

user function viewZZV()

	local aArea := getArea()
	local cSeek := xFilial( 'ZZV' ) + ZZY->ZZY_PRODUT

	Private cCadastro := "Produto da Oportunidade"

	dbSelectArea( 'ZZV' )
	ZZV->( dbSetOrder( 1 ) )

	if ZZV->( msSeek( cSeek ) .And. cSeek == ZZV_FILIAL + ZZV_CODIGO )

		AxVisual( 'ZZV', ZZV->(RecNo()), 2 )

	else

		apMsgStop( 'Produto da Oportunidade não localizado', 'Atenção !!!' )

	end

	restArea( aArea )

return

user function viewZZX()

	local aArea := getArea()
	local cSeek := xFilial( 'ZZX' ) + ZZY->ZZY_IDCLI

	Private cCadastro := "Contato da Oportunidade"

	dbSelectArea( 'ZZX' )
	ZZX->( dbSetOrder( 3 ) )

	if ZZX->( msSeek( cSeek ) .And. cSeek == ZZX_FILIAL + ZZX_ID )

		AxVisual( 'ZZX', ZZX->(RecNo()), 2 )

	else

		apMsgStop( 'Produto da Oportunidade não localizado', 'Atenção !!!' )

	end

	restArea( aArea )

return

user function viewZZY()

	local aRotinas    := {}
	Private cCadastro := "Oportunidades"

	aAdd( aRotinas, { '', { || U_viewZZV() }, 'Produto da Oportunidade' } )
	aAdd( aRotinas, { '', { || U_viewZZX() }, 'Contato da Oportunidade' } )

	AxVisual( 'ZZY', ZZY->(RecNo()), 2,,,,, aRotinas )

return

