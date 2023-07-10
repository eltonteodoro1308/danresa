#include 'totvs.ch'
#include "report.ch"
#include 'fwmvcdef.ch'

static function menudef()

	local aRet := {}

	aAdd( aRet, { 'Relatório', 'U_rSC6_ZZY'  , 0, 8, 0,,, } )

return aRet

user function rSC6_ZZY()

	private cPergunta := 'GESTVENDAS'
	private oReport   := nil
	private oSecCab   := nil
	private cAlias    := ''

	if pergunte( cPergunta, .T. )

		oReport := TReport():New( "GESTVENDAS","Gestão de Vendas",;
			'GESTVENDAS', { | oReport| PrintReport( oReport ) },;
			"Impresão do relacionamento das oportunidades integradas do Nectar Crm x pedidos de vendas")

		oSecCab := TRSection():New( oReport , "Gestão de Vendas", { cAlias } )

		TRCell():New( oSecCab, "ZZY_CODIGO" , cAlias )
		TRCell():New( oSecCab, "ZZY_PEDGER" , cAlias )
		TRCell():New( oSecCab, "C6_NUM"     , cAlias )
		TRCell():New( oSecCab, "C6_QTDVEN"  , cAlias )
		TRCell():New( oSecCab, "C6_QTDENT"  , cAlias )
		TRCell():New( oSecCab, "B1_COD"     , cAlias )
		TRCell():New( oSecCab, "B1_DESC"    , cAlias )
		TRCell():New( oSecCab, "A1_COD"     , cAlias )
		TRCell():New( oSecCab, "A1_LOJA"    , cAlias )
		TRCell():New( oSecCab, "A1_NOME"    , cAlias )

		oReport:PrintDialog()

	EndIf

return

static function PrintReport( oReport )

	local cQuery := mntQry()

	cAlias := MPSysOpenQuery( cQuery )

	// oSecCab:BeginQuery()
	// oSecCab:setQuery( cAlias, cQuery )
	// oSecCab:EndQuery(  )
	// oSecCab:Print()

	( cAlias )->( dbGoTop() )

	if ( cAlias )->( ! EOF() )

		oSecCab:init()

		do while ( cAlias )->( ! EOF() )

			oSecCab:cell("ZZY_CODIGO"):setValue( ( cAlias )->ZZY_CODIGO )
			oSecCab:cell("ZZY_PEDGER"):setValue( ( cAlias )->ZZY_PEDGER )
			oSecCab:cell("C6_NUM"    ):setValue( ( cAlias )->C6_NUM     )
			oSecCab:cell("C6_QTDVEN" ):setValue( ( cAlias )->C6_QTDVEN  )
			oSecCab:cell("C6_QTDENT" ):setValue( ( cAlias )->C6_QTDENT  )
			oSecCab:cell("B1_COD"    ):setValue( ( cAlias )->B1_COD     )
			oSecCab:cell("B1_DESC"   ):setValue( ( cAlias )->B1_DESC    )
			oSecCab:cell("A1_COD"    ):setValue( ( cAlias )->A1_COD     )
			oSecCab:cell("A1_LOJA"   ):setValue( ( cAlias )->A1_LOJA    )
			oSecCab:cell("A1_NOME"   ):setValue( ( cAlias )->A1_NOME    )

			oSecCab:printLine()

			( cAlias )->( dbSkip() )

		end do

		oSecCab:finish()

	end if

return

static function mntQry()

	local cQuery := ''
	local cOportDe    := MV_PAR01
	local cOportAte   := MV_PAR02
	local cCriacaoDe  := dtos( MV_PAR03 )
	local cCriacaoAte := dtos( MV_PAR04 )
	local cZZYTable   := retSqlName('ZZY')
	local cSC6Table   := retSqlName('SC6')
	local cSA1Table   := retSqlName('SA1')
	local cSB1Table   := retSqlName('SB1')
	local cZZYFilial  := FwXFilial('ZZY')

	BeginContent var cQuery

	SELECT

	ZZY.ZZY_CODIGO,
CASE ZZY.ZZY_PEDGER
	WHEN 'T' THEN 'Sim'
ELSE 'Não'
END ZZY_PEDGER,
SC6.C6_NUM,
SC6.C6_QTDVEN,
SC6.C6_QTDENT,
SB1.B1_COD,
SB1.B1_DESC,
SA1.A1_COD,
SA1.A1_LOJA,
SA1.A1_NOME

FROM %Exp:cZZYTable% ZZY

LEFT JOIN %Exp:cSC6Table% SC6
ON  SC6.D_E_L_E_T_ = ZZY.D_E_L_E_T_
AND SC6.C6_FILIAL  = ZZY.ZZY_FILIAL
AND SC6.C6_XOPORTU = ZZY.ZZY_CODIGO
AND SC6.C6_XITOPOR = ZZY.ZZY_ITEM

LEFT JOIN %Exp:cSA1Table% SA1
ON  SC6.D_E_L_E_T_ = SA1.D_E_L_E_T_
AND SC6.C6_CLI     = SA1.A1_COD
AND SC6.C6_LOJA    = SA1.A1_LOJA

LEFT JOIN %Exp:cSB1Table% SB1
ON  SC6.D_E_L_E_T_ = SB1.D_E_L_E_T_
AND SC6.C6_PRODUTO = SB1.B1_COD

WHERE ZZY.D_E_L_E_T_ = ' '
AND ZZY.ZZY_FILIAL = '%Exp:cZZYFilial%'
AND ZZY.ZZY_CODIGO BETWEEN '%Exp:cOportDe%' AND '%Exp:cOportAte%'
AND ZZY.ZZY_DTCRIA BETWEEN '%Exp:cCriacaoDe%' AND '%Exp:cCriacaoAte%'

EndContent


return cQuery
