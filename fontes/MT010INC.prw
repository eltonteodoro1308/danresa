#include 'totvs.ch'

user function MT010INC()

	Local aArea    := getArea()
	Local cCommand := ''
	Local cSeekSB2 := ''

	if fwIsInCallStack('U_nectarCockipt')

		chkFile( 'ZZZ' )

		// Criar relacionamento de produto nectar com produto protheus
		dbSelectArea( 'ZZZ' )

		recLock( 'ZZZ', .T. )

		ZZZ->ZZZ_FILIAL := Xfilial( 'ZZZ' )
		ZZZ->ZZZ_CDNECT := ZZV->ZZV_CODIGO
		ZZZ->ZZZ_CDPROT := SB1->B1_COD

		ZZZ->( msUnlock() )

		dbSelectArea( 'SB2' )
		SB2->( dbSetOrder( 1 ) )

		if ! SB2->( msSeek( cSeekSB2 := xFilial( 'SB2' ) + SB1->( B1_COD + B1_LOCPAD ) ) .And.;
				cSeekSB2 == B2_FILIAL + B2_COD + B2_LOCAL )

			SB1->( CriaSB2( B1_COD, B1_LOCPAD ) ) // Gera Local de Estocagem do Produto

		end if

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
