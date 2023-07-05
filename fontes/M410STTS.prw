#include 'totvs.ch'

User Function M410STTS()

	Local nOper := PARAMIXB[1]
	local nX        := 0
	local cFormatIn := ''
	local cCommand  := ''

	if fwIsInCallStack('U_nectarCockipt') .And. nOper == 3

		for nX := 1 to len( _aLstOport )

			cFormatIn += "'" + allTrim( _aLstOport[nX] ) + "'"

			if nX != len( _aLstOport )

				cFormatIn += ","

			end if

		next nX

		// Marcar Oportunidade como pedido gerado
		cCommand := " UPDATE " + retSqlName( 'ZZY' )
		cCommand += " SET ZZY_PEDGER = 'T', ZZY_OK = ' ' "
		cCommand += " WHERE ZZY_CODIGO IN(" + cFormatIn + ")"

		if tcSqlExec( cCommand ) < 0

			autoGrLog( 'Erro ao gravar no Banco de Dados: ' + CRLF + TCSQLError() )
			mostraErro()

		end if

	end if

Return
