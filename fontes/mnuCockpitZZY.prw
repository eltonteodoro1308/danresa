#include 'totvs.ch'
#include 'fwmvcdef.ch'

static function menudef()

    local aRet := {}

    aAdd( aRet, { 'Gerar Pedido'           , 'U_XINC410' , 0, 8, 0,,, } )
    aAdd( aRet, { 'Compatibilizar Cliente' , 'U_XINC980' , 0, 8, 0,,, } )
    aAdd( aRet, { 'Compatibilizar Produto' , 'U_XINC010' , 0, 8, 0,,, } )

return aRet

user function XINC980()

	dbSelectArea('SA1')
	FWExecView("Incluir","CRMA980",MODEL_OPERATION_INSERT,/*oDlg*/,/*bCloseOnOk*/,/*bOk*/,/*nPercReducao*/)

return

user function XINC010()

	A010INCLUI(/*cAlias*/,/*nReg*/,/*nOpc*/)

return

user function XINC410()

	Local nOpc := 3

	Private cCadastro  := "Atualização de Pedidos de Venda"
	Private INCLUI     := .T.
	Private aRotina    := FWLoadMenuDef( 'MATA410' )

	A410Inclui(/*cAlias*/,/*nReg*/, nOpc /*,lOrcamento,nStack,aRegSCK,lContrat,nTpContr,cCodCli,cLoja,cMedPMS*/)

return

