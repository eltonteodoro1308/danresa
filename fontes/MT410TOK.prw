#include 'totvs.ch'

User Function MT410TOK()

    /*
    aParamIxb := nOpc
    aParamIxb := aRecnoSE1RA
    */

	if fwIsInCallStack('U_nectarCockipt')

		recLock( 'ZZY', .T. )
		ZZY->ZZY_PEDGER := .T.
		ZZY->( msUnlock() )

	end if

Return .T.
