#include 'totvs.ch'

user function MT010INC()

	Local aArea    := getArea()
	Local cCommand := ''

	if fwIsInCallStack('U_nectarCockipt')

        chkFile( 'ZZZ' )

		// Criar relacionamento de produto nectar com produto protheus
		dbSelectArea( 'ZZZ' )

		recLock( 'ZZZ', .T. )

		ZZZ->ZZZ_FILIAL := Xfilial( 'ZZZ' )
		ZZZ->ZZZ_CDNECT := ZZV->ZZV_CODIGO
		ZZZ->ZZZ_CDPROT := SB1->B1_COD

		ZZZ->( msUnlock() )

		// Marcar Oportunidade como produto compatibilizado
		cCommand := " UPDATE " + retSqlName( 'ZZY' )
		cCommand += " SET ZZY_PRDCMP = 'T' "
		cCommand += " WHERE ZZY_PRODUT = '" + ZZV->ZZV_CODIGO + "' "

		if tcSqlExec(cCommand ) < 0

            autoGrLog( 'Erro ao gravar no Banco de Dados: ' + CRLF + TCSQLError() )
            mostraErro()

		end if

	end if

	restArea( aArea )

return
