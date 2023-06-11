#include 'totvs.ch'
#include 'fwmvcdef.ch'

user function CRMA980()

	Local oObj       := PARAMIXB[1]
	Local cIdPonto   := PARAMIXB[2]
	Local cIdModel   := PARAMIXB[3]
	Local xRet       := .T.
	Local cCommand   := ''

	if fwIsInCallStack('U_nectarCockipt')

		if cIdPonto == 'MODELCOMMITNTTS'

			// Marcar Oportunidade como cliente compatibilizado
			cCommand := " UPDATE " + retSqlName( 'ZZY' )
			cCommand += " SET ZZY_CLICMP = 'T' "
			cCommand += " WHERE ZZY_IDCLI = '" + ZZX->ZZX_ID + "' "

			if tcSqlExec(cCommand ) < 0

				autoGrLog( 'Erro ao gravar no Banco de Dados: ' + CRLF + TCSQLError() )
				mostraErro()

			end if

		elseIf cIdPonto == 'BUTTONBAR'

			xRet := {}

		else

		end If

	end If

return xRet
