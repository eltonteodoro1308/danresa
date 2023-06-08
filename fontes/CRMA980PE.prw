#include 'totvs.ch'
#include 'fwmvcdef.ch'

user function CRMA980()

	Local oObj       := PARAMIXB[1]
	Local cIdPonto   := PARAMIXB[2]
	Local cIdModel   := PARAMIXB[3]
	Local xRet       := .T.

	if cIdPonto == 'MODELCOMMITNTTS'

		conOut('*** *** ***') // Grava código do cliente protheus na oportunidade e no cadastro de cliente

	elseIf cIdPonto == 'BUTTONBAR'

		oObj:getModel('SA1MASTER'):setValue('A1_NOME','elton')

		oview := fwviewactive()

        oview:refresh()

		xRet := {}

	else

	end If

return xRet
